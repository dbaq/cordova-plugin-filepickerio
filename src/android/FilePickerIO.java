package com.dbaq.cordova.filepickerio;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.provider.ContactsContract.Contacts.Data;
import android.util.Log;

public class FilePickerIO extends CordovaPlugin {

    private CallbackContext callbackContext;
    
    private JSONArray executeArgs;
    
    public static final String ACTION_PICK = "pick";
    
    private static final String LOG_TAG = "FilePickerIO";
    
    public FilePickerIO() {}

    /**
     * Executes the request and returns PluginResult.
     *
     * @param action            The action to execute.
     * @param args              JSONArray of arguments for the plugin.
     * @param callbackContext   The callback context used when calling back into JavaScript.
     * @return                  True if the action was valid, false otherwise.
     */
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
        
        this.callbackContext = callbackContext;
        this.executeArgs = args; 
        
        if (ACTION_PICK.equals(action)) {
            this.cordova.getThreadPool().execute(new Runnable() {
                public void run() {
                    callbackContext.success("picked");
                }
            });    
            return true;
        }
        
        return false;
    }
}
