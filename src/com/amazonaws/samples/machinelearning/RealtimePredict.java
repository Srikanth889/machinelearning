
package com.amazonaws.samples.machinelearning;

import java.util.HashMap;
import java.util.Map;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.services.machinelearning.AmazonMachineLearningClient;
import com.amazonaws.services.machinelearning.model.GetMLModelRequest;
import com.amazonaws.services.machinelearning.model.GetMLModelResult;
import com.amazonaws.services.machinelearning.model.PredictRequest;
import com.amazonaws.services.machinelearning.model.PredictResult;

/**
 * Simple command-line realtime prediction utility
 * 
 * Usage:
 *   java RealtimePredict mlModelId attribute1=value1 attribute2=value2 ...
 *   
 * Multi-word text attributes can be specified like:
 *   java RealtimePredict ml-12345678901 "textVar=Multiple words grouped together" numericVar=123
 */
public class RealtimePredict {

    public static void main(String[] args) {

    }
    public PredictResult testr(String[] args) {
        String mlModelId = args[0];
        RealtimePredict rtp = new RealtimePredict(mlModelId);
        Map<String,String> record = rtp.parseArgs(args);
        PredictResult response = rtp.predict(record);
		return response;
    }
    private AmazonMachineLearningClient client;
    private String mlModelId;
    private String predictEndpoint = "https://realtime.machinelearning.us-east-1.amazonaws.com";
    
    public RealtimePredict(String mlModelId) {
    	AWSCredentials as = new AWSCredentials() {
			
			@Override
			public String getAWSSecretKey() {
				return "tX2ESFIftdm6AkZ2Oi+/7YDezzvMoWzU13mA15rD";
			}
			
			@Override
			public String getAWSAccessKeyId() {
				return "AKIAJFQIT6MS6Q4C3U7A";
			}
		};
        client = new AmazonMachineLearningClient(as);
        this.mlModelId = mlModelId;
    }
    
    
    private Map<String, String> parseArgs(String[] args) {
        Map<String, String> record = new HashMap<String,String>();
        
        for(int i=1; i<args.length; i++) {
            String arg = args[i];
            String[] parts = arg.split("=");
            if( parts.length != 2 ) {
                throw new RuntimeException("Command line arguments must take form attributeName=value");
            }
            record.put(parts[0],parts[1]);
        }
        return record;
    }

    
    private PredictResult predict(Map<String, String> record) {
        lookupEndpoint();
        PredictRequest request = new PredictRequest()
            .withMLModelId(mlModelId)
            .withPredictEndpoint(predictEndpoint)
            .withRecord(record);
        return client.predict(request);
    }


    /**
     * finds the realtime endpoint for this ML Model
     */
    private void lookupEndpoint() {
        GetMLModelRequest request = new GetMLModelRequest().withMLModelId(mlModelId);
        GetMLModelResult model = client.getMLModel(request);
        predictEndpoint = model.getEndpointInfo().getEndpointUrl();
    }
    
    
    /**
     * Simple method that makes a realtime prediction and prints the result.
     * WARNING! This only works in the happy case, and doesn't check for
     * error conditions like the lack of a realtime endpoint.
     * @param mlModelId the ML model's identifier
     * @param record all the attributes in the record to make a prediction on
     */
    public static PredictResult simpleHappyCasePrediction(String mlModelId, Map<String,String> record) {
        AmazonMachineLearningClient client = new AmazonMachineLearningClient();
        
        GetMLModelRequest modelRequest = new GetMLModelRequest().withMLModelId(mlModelId);
        GetMLModelResult model = client.getMLModel(modelRequest);
        String predictEndpoint = model.getEndpointInfo().getEndpointUrl();
        
        PredictRequest predictRequest = new PredictRequest()
            .withMLModelId(mlModelId)
            .withPredictEndpoint(predictEndpoint)
            .withRecord(record);
        PredictResult prediction = client.predict(predictRequest);
        return prediction;
    }

}
