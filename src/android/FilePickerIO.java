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
    
    public static final String ACTION_SET_KEY = "setKey";
    
    public static final String ACTION_SET_NAME = "setName";

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

                try {
                    if (ACTION_SET_KEY.equals(action)) {
                        Filepicker.setKey(args.getString(0));
                        return;
                    }
                    if (ACTION_SET_NAME.equals(action)) {
                        Filepicker.setAppName(args.getString(0));
                        return;
                    }

                    Context context = cordova.getActivity().getApplicationContext();
                    Intent intent = new Intent(context, Filepicker.class);
                    if (ACTION_PICK.equals(action) || ACTION_PICK_AND_STORE.equals(action)) {
                            parseGlobalArgs(intent, args);
                            if (ACTION_PICK_AND_STORE.equals(action)) {
                                parseStoreArgs(intent, args);
                            }
                       

                        cordova.startActivityForResult(cdvPlugin, intent, Filepicker.REQUEST_CODE_GETFILE);  
                    }
                }
                catch(JSONException exception) {
                    callbackContext.error("cannot parse json");
                }
            }
        });  
        
        return true;
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == Filepicker.REQUEST_CODE_GETFILE) {
            if (resultCode == Activity.RESULT_OK) {
                ArrayList<FPFile> fpFiles = data.getParcelableArrayListExtra(Filepicker.FPFILES_EXTRA);
                callbackContext.success(toJSON(fpFiles)); // Filepicker always returns array of FPFile objects
            } else {
                callbackContext.error("nok");
            }
        }
        else {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }

    public void parseGlobalArgs(Intent intent, JSONArray args) throws JSONException {
        if (!args.isNull(0)) {
            intent.putExtra("mimetype", parseJSONStringArray(args.getJSONArray(0)));
        }
        if (!args.isNull(1)) {
            intent.putExtra("services", parseJSONStringArray(args.getJSONArray(1)));
        }
        if (!args.isNull(2)) {
            intent.putExtra("multiple", args.getBoolean(2));
        }
        if (!args.isNull(3)) {
            intent.putExtra("maxFiles", args.getInt(3));
        }
        if (!args.isNull(4)) {
            intent.putExtra("maxSize", args.getInt(4));
        }
    }

    public void parseStoreArgs(Intent intent, JSONArray args) throws JSONException {
        if (!args.isNull(5)) {
            intent.putExtra("location", args.getString(5));
        }
        if (!args.isNull(6)) {
            intent.putExtra("path", args.getString(6));
        }
        if (!args.isNull(7)) {
            intent.putExtra("container", args.getString(7));
        }
        if (!args.isNull(8)) {
            intent.putExtra("access", args.getString(8));
        }
    }

    public String[] parseJSONStringArray(JSONArray jSONArray) throws JSONException {
        String[] a = new String[jSONArray.length()];
        for(int i = 0; i < jSONArray.length(); i++){
            a[i] = jSONArray.getString(i);
        }
        return a;
    }

    public JSONArray toJSON(ArrayList<FPFile> fpFiles) {
        JSONArray res = new JSONArray();
        for (FPFile fpFile : fpFiles) {
            java.util.Map f = new java.util.HashMap<String, Object>();
            f.put("container", fpFile.getContainer());
            f.put("url", fpFile.getUrl());
            f.put("filename", fpFile.getFilename());
            f.put("key", fpFile.getKey());
            f.put("type", fpFile.getType());
            f.put("localPath", fpFile.getLocalPath());
            f.put("size", fpFile.getSize());

            res.put(f);
        }
        return res;
    }
}
