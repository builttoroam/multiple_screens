package com.builttoroam.multiple_screens

import android.app.Activity
import android.content.Context
import android.content.Context.SENSOR_SERVICE
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.view.View
import android.view.View.OnLayoutChangeListener
import androidx.annotation.NonNull
import com.builttoroam.multiple_screens.models.Hinge
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.microsoft.device.display.DisplayMask
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


/** MultipleScreensPlugin */
class MultipleScreensPlugin :
    FlutterPlugin,
    MethodCallHandler,
    EventChannel.StreamHandler,
    ActivityAware {
    private val METHOD_CHANNEL_NAME = "plugins.builttoroam.com/multiple_screens/methods"
    private val EVENT_CHANNEL_NAME = "plugins.builttoroam.com/multiple_screens/events"
    private val DISPLAY_MASK_SYSTEM_FEATURE = "com.microsoft.device.display.displaymask"
    private val IS_MULTIPLE_SCREENS_DEVICE = "isMultipleScreensDevice"
    private val IS_APP_SPANNED = "isAppSpanned"
    private val GET_HINGE = "getHinge"
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var context: Context? = null
    private var activity: Activity? = null
    private var gson: Gson? = null

    private val HINGE_ANGLE_SENSOR_NAME = "Hinge Angle"
    private var sensorManager: SensorManager? = null
    private var hingeAngleSensor: Sensor? = null
    private var sensorListener: SensorEventListener? = null
    private var hinge: Hinge = Hinge()

    fun registerPlugin(context: Context?, messenger: BinaryMessenger?) {
        this.context = context
        this.methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
        this.methodChannel.setMethodCallHandler(this)
        this.eventChannel = EventChannel(messenger, EVENT_CHANNEL_NAME)
        this.eventChannel.setStreamHandler(this)

        gson = GsonBuilder().create()
        setupSensors()
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        this.registerPlugin(binding.applicationContext, binding.binaryMessenger)
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            MultipleScreensPlugin().registerPlugin(registrar.context(), registrar.messenger())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            IS_MULTIPLE_SCREENS_DEVICE -> {
                result.success(isMultipleScreensDevice())
            }
            IS_APP_SPANNED -> {
                result.success(isAppSpanned())
            }
            GET_HINGE -> {
                result.success(gson?.toJson(hinge))
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventSink?) {
        activity?.window?.decorView?.rootView?.addOnLayoutChangeListener(object : OnLayoutChangeListener {
            override fun onLayoutChange(
                v: View?,
                left: Int,
                top: Int,
                right: Int,
                bottom: Int,
                oldLeft: Int,
                oldTop: Int,
                oldRight: Int,
                oldBottom: Int
            ) {
                events?.success(isAppSpanned())
            }
        })
    }

    override fun onCancel(arguments: Any?) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    private fun isMultipleScreensDevice(): Boolean {
        val packageManager = context?.packageManager
        if (packageManager != null) {
            return packageManager.hasSystemFeature(
                DISPLAY_MASK_SYSTEM_FEATURE
            )
        }
        return false
    }

    fun isAppSpanned(): Boolean {
        if (isMultipleScreensDevice()) {
            val bounding = DisplayMask.fromResourcesRectApproximation(activity).boundingRects
            if (bounding.isEmpty()) {
                return false
            }
            val drawingRect = android.graphics.Rect()
            activity?.window?.decorView?.rootView?.getDrawingRect(drawingRect)
            return bounding.first().intersect(drawingRect)
        }
        return false
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        context = null
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    private fun setupSensors() {
        sensorManager = context?.getSystemService(SENSOR_SERVICE) as SensorManager?
        val sensorList = sensorManager!!.getSensorList(Sensor.TYPE_ALL)
        for (sensor in sensorList) {
            if (sensor.name.contains(HINGE_ANGLE_SENSOR_NAME)) {
                hingeAngleSensor = sensor
            }
        }
        sensorListener = object : SensorEventListener {
            override fun onSensorChanged(event: SensorEvent) {
                if (event.sensor == hingeAngleSensor) {
                    hinge.angle = event.values[0].toInt()
                }
            }

            override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {
                hinge.accuracy = accuracy
            }
        }

        sensorManager!!.registerListener(sensorListener, hingeAngleSensor, SensorManager.SENSOR_DELAY_NORMAL)
    }
}
