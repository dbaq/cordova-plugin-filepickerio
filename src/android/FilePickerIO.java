package com.dbaq.cordova.filepickerio;

import java.util.ArrayList;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.content.ContentResolver;
import android.content.Intent;
import android.provider.ContactsContract.Contacts.Data;
import android.util.Log;

import io.filepicker.Filepicker;
import io.filepicker.models.FPFile;

public class FilePickerIO extends CordovaPlugin {

    private CallbackContext callbackContext;
    
    private JSONArray executeArgs;
    
    public static final String ACTION_PICK = "pick";
    
    private static final String LOG_TAG = "FilePickerIO";


    // REQUIRED FIELD
    private static final String FILEPICKER_API_KEY = "KEY";

    // OPTIONAL FIELD
    private static final String PARENT_APP = "APP";
    
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

        final CordovaPlugin cdvPlugin = this;
 
        
        if (ACTION_PICK.equals(action)) {
            this.cordova.getThreadPool().execute(new Runnable() {
                public void run() {
                    //callbackContext.success("picked");

                    Filepicker.setKey(FILEPICKER_API_KEY);
                    Filepicker.setAppName(PARENT_APP);

                    Context context = cordova.getActivity().getApplicationContext();
                    cordova.startActivityForResult(cdvPlugin, new Intent(context, Filepicker.class), Filepicker.REQUEST_CODE_GETFILE);
                }
            });    
            return true;
        }
        
        return false;
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {

        if (requestCode == Filepicker.REQUEST_CODE_GETFILE) {
            if (resultCode == Activity.RESULT_OK) {
                // Filepicker always returns array of FPFile objects
                ArrayList<FPFile> fpFiles = data.getParcelableArrayListExtra(Filepicker.FPFILES_EXTRA);

                // Get first object (use if multiple option is not set)
                FPFile file = fpFiles.get(0);
                callbackContext.success(file.getUrl());
 
            } else if(resultCode == Activity.RESULT_CANCELED && data != null) {
                // Uri fileUri = data.getData();

                // Filepicker.uploadLocalFile(fileUri, this);
                callbackContext.success("hello");
            }
        }
        else {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }
}
