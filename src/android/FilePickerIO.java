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

    public static final String ACTION_PICK_AND_STORE = "pickAndStore";
    
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
    public boolean execute(final String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        
        this.callbackContext = callbackContext;
        this.executeArgs = args; 

        final CordovaPlugin cdvPlugin = this;
        
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {


                Context context = cordova.getActivity().getApplicationContext();
                Intent intent = new Intent(context, Filepicker.class);
                if (ACTION_PICK.equals(action) || ACTION_PICK_AND_STORE.equals(action)) {
                    try {
                        parseGlobalArgs(intent, args);
                        if (ACTION_PICK_AND_STORE.equals(action)) {
                            parseStoreArgs(intent, args);
                        }
                    }
                    catch(JSONException exception) {
                        callbackContext.error("cannot parse json");
                    }

                    cordova.startActivityForResult(cdvPlugin, intent, Filepicker.REQUEST_CODE_GETFILE);  
                }
            }
        });  
        
        return true;
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

    public void parseGlobalArgs(Intent intent, JSONArray args) throws JSONException {
        Filepicker.setKey(args.getString(0));
        if (!args.isNull(1)) {
            Filepicker.setAppName(args.getString(1));
        }
        if (!args.isNull(2)) {
            intent.putExtra("mimetype", parseJSONStringArray(args.getJSONArray(2)));
        }
        if (!args.isNull(3)) {
            intent.putExtra("services", parseJSONStringArray(args.getJSONArray(3)));
        }
        if (!args.isNull(4)) {
            intent.putExtra("multiple", args.getBoolean(4));
        }
        if (!args.isNull(5)) {
            intent.putExtra("maxFiles", args.getInt(5));
        }
        if (!args.isNull(6)) {
            intent.putExtra("maxSize", args.getInt(6));
        }
    }

    public void parseStoreArgs(Intent intent, JSONArray args) throws JSONException {
        if (!args.isNull(7)) {
            intent.putExtra("location", args.getString(7));
        }
        if (!args.isNull(8)) {
            intent.putExtra("path", args.getString(8));
        }
        if (!args.isNull(9)) {
            intent.putExtra("container", args.getString(9));
        }
        if (!args.isNull(10)) {
            intent.putExtra("access", args.getString(10));
        }
    }

    public String[] parseJSONStringArray(JSONArray jSONArray) throws JSONException {
        String[] a = new String[jSONArray.length()];
        for(int i = 0; i < jSONArray.length(); i++){
            a[i] = jSONArray.getString(i);
        }
        return a;
    }
}
