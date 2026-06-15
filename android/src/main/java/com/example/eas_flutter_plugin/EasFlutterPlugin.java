package com.example.eas_flutter_plugin;

import android.app.Activity;
import android.app.Application;
import androidx.annotation.NonNull;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import com.fineboost.utils.LogUtils;
import com.fineboost.sdk.dataacqu.Constants;
import com.fineboost.sdk.dataacqu.YFDataAgent;
import com.fineboost.sdk.dataacqu.listener.AcquExitCallBack;
import com.fineboost.sdk.dataacqu.listener.AcquInitCallBack;
import com.fineboost.sdk.dataacqu.listener.RegionCallback;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/** EasFlutterPlugin */
public class EasFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private MethodChannel channel;
  private Context mContext;
  private Activity mActivity;  // 新增

  private static final Map<String, Object> EMPTY_HASH_MAP = new HashMap<>();
  private static final String TAG = "EasFlutterPlugin";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.mContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "eas_flutter_plugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.mActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.mActivity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.mActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    //this.mActivity = null;
  }

    @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    LogUtils.d("YFDataAgent onMethodCall:"+call.method);
    String appId = call.argument("appId");
    if ("getPlatformVersion".equals(call.method)) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }
    else if ("initSdk".equals(call.method)) {
      LogUtils.d("YFDataAgent init:"+appId);
      YFDataAgent.init(this.mActivity, null);
      YFDataAgent instance = YFDataAgent.sharedInstance(this.mActivity,appId);
      result.success(null);
    }
    else if ("login".equals(call.method)) {
      String accountId = call.argument("accountId");
      String networkName = call.argument("networkName");
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.login(accountId, networkName);
      } else {
        YFDataAgent.setLoginAccount(accountId, networkName);
      }
      result.success(null);
    }
    else if ("userAdd".equals(call.method)) {
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.userAdd(properties);
      } else {
        YFDataAgent.trackUserAdd(properties);
      }
      result.success(null);
    }
    else if ("userSet".equals(call.method)) {
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.userSet(properties);
      } else {
        YFDataAgent.trackUserSet(properties);
      }
      result.success(null);
    }
    else if ("userSetOnce".equals(call.method)) {
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.userSetOnce(properties);
      } else {
        YFDataAgent.trackUserSetOnce(properties);
      }
      result.success(null);
    }
    else if ("userAppend".equals(call.method)) {
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");
      JSONObject mProperties;
      try {
        mProperties = extractJSONObject(properties == null ? EMPTY_HASH_MAP : properties);
        if (!TextUtils.isEmpty(appId)){
          YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
          instance.userAppend(mProperties);
        } else {
          YFDataAgent.trackUserAppend(mProperties);
        }
      } catch (Exception e) {
        Log.e(TAG, e.toString());
        result.error(e.getClass().getName(), e.toString(), "");
        return;
      }
      result.success(null);
    }
    else if ("userUniqAppend".equals(call.method)) {
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");

      JSONObject mProperties;
      try {
        mProperties = extractJSONObject(properties == null ? EMPTY_HASH_MAP : properties);
        if (!TextUtils.isEmpty(appId)){
          YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
          instance.userUnIqAppend(mProperties);
        } else {
          YFDataAgent.trackUserUnIqAppend(mProperties);
        }
      } catch (Exception e) {
        Log.e(TAG, e.toString());
        result.error(e.getClass().getName(), e.toString(), "");
        return;
      }
      result.success(null);
    }
    else if ("userUnset".equals(call.method)) {
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");
      String[] keyList = properties != null ? properties.keySet().toArray(new String[0]) : new String[0];
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.userUnset(keyList);
      } else {
        YFDataAgent.trackUserUnset(keyList);
      }
      result.success(null);
    }
    else if ("track".equals(call.method)) {
      String eventName = call.argument("eventName");
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.event(eventName,properties);
      } else {
        YFDataAgent.trackEvents(eventName,properties);
      }
      result.success(null);
    }
    else if ("sdkVersion".equals(call.method)) {
      String version ="";
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        version = instance.getVersion();
      } else {
        version = "5.0.55";
      }
      result.success(version);
    }
    else if ("setSuperProperties".equals(call.method)) {
      Map<String, Object> properties = call.<HashMap<String, Object>>argument("properties");

      JSONObject mProperties;
      try {
        mProperties = extractJSONObject(properties == null ? EMPTY_HASH_MAP : properties);
        if (!TextUtils.isEmpty(appId)){
          YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
          instance.setSuperProps(mProperties);
        } else {
          YFDataAgent.setSuperProperties(mProperties);
        }
      } catch (Exception e) {
        Log.e(TAG, e.toString());
        result.error(e.getClass().getName(), e.toString(), "");
        return;
      }
      result.success(null);
    }
    else if ("getSuperProperties".equals(call.method)) {
      JSONObject mProperties = null;
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        mProperties = instance.getSuperProps();
      } else {
        mProperties = YFDataAgent.getSuperProperties();
      }
      if (mProperties != null) {
        result.success(jsonToMap(mProperties));
      } else {
        result.success(null);
      }
    }
    else if ("unsetSuperProperty".equals(call.method)) {
      String key = call.argument("property");
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.unsetSuperPro(key);
      } else {
        YFDataAgent.unsetSuperProperty(key);
      }
      result.success(null);
    }
    else if ("clearSuperProperties".equals(call.method)) {

      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.clearSuperProps();
      } else {
        YFDataAgent.clearSuperProperties();
      }
      result.success(null);
    }
    else if ("flush".equals(call.method)) {
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        instance.flush();
      } else {
        YFDataAgent.flushData();
      }
      result.success(null);
    }
    else if ("enableLog".equals(call.method)) {
      Boolean enable = call.argument("enable");
      if (enable == null) {
        enable = true;
      }
      if(enable){
        LogUtils.setDebug(enable);
      }
      result.success(null);
    }
    else if ("getDataFid".equals(call.method)) {
      String fid = "";
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        fid = instance.getYFDataFid();
      } else {
        fid = YFDataAgent.getDataFid();
      }
      result.success(fid);
    }
    else if ("getDataGeo".equals(call.method)) {
      String geo = "";
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        geo = instance.getGeo();
      } else {
        geo = YFDataAgent.getDataGeo();
      }
      result.success(geo);
    }
    else if ("getDataBid".equals(call.method)) {
      String bid = "";
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        bid = instance.getBid();
      } else {
        bid = YFDataAgent.getDataBid();
      }
      result.success(bid);
    }
    else if ("getDataActiviteDays".equals(call.method)) {
      int activiteDays = -1;
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        activiteDays = instance.getActiviteDays();
      } else {
        activiteDays = YFDataAgent.getDataActiviteDays();
      }
      result.success(activiteDays);
    }
    else if ("getDataFirstStartTime".equals(call.method)) {
      long firstStartTime = -1;
      if (!TextUtils.isEmpty(appId)){
        YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
        firstStartTime = instance.getFirstStartTime();
      } else {
        firstStartTime = YFDataAgent.getDataFirstStartTime();
      }

      result.success(String.valueOf(firstStartTime));
    }
    else if ("getRegion".equals(call.method)) {
      YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
      instance.getRegoin(new RegionCallback() {
        @Override
        public void onRegSuccess(String reg) {
          result.success(reg);
        }

        @Override
        public void onRegFailed(String error) {
          result.success(error);
        }
      });
    }
    else if ("exitAcquApp".equals(call.method)) {
      YFDataAgent instance = YFDataAgent.sharedInstance(mContext,appId);
      instance.exitApp(new AcquExitCallBack() {
        @Override
        public void onExit() {
          Boolean isExit = true;
          result.success(isExit);
        }
      });

    }
    else {
      result.notImplemented();
    }
  }

  @SuppressWarnings("unchecked")
  private JSONObject extractJSONObject(Map<String, Object> properties) throws JSONException {
    JSONObject jsonObject = new JSONObject();
    if (properties != null) {
      for (String key : properties.keySet()) {
        Object value = properties.get(key);
        if (value instanceof Map<?, ?>) {
          value = extractJSONObject((Map<String, Object>) value);
        } else if (value instanceof List) {
          value = new JSONArray((List) value);
        }
        jsonObject.put(key, value);
      }
    }
    return jsonObject;
  }

  private Map<String, Object> jsonToMap(JSONObject properties) {
    Map<String, Object> mapProperties = new HashMap<>();
    Iterator<String> keys = properties.keys();
    while (keys.hasNext()) {
      String key = keys.next();
      Object value = properties.opt(key);
      if (value instanceof JSONObject) {
        mapProperties.put(key, jsonToMap((JSONObject) value));
      } else if (value instanceof JSONArray) {
        mapProperties.put(key, jsonArrayToList((JSONArray) value));
      } else {
        mapProperties.put(key, value);
      }
    }
    return mapProperties;
  }
  
  private List<Object> jsonArrayToList(JSONArray jsonArr) {
    List<Object> lists = new ArrayList<>();
    for (int i = 0; i < jsonArr.length(); i++) {
      Object value = jsonArr.opt(i);
      if (value instanceof JSONObject) {
        lists.add(jsonToMap((JSONObject) value));
      } else if (value instanceof JSONArray) {
        lists.add(jsonArrayToList((JSONArray) value));
      } else {
        lists.add(value);
      }
    }
    return lists;
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
