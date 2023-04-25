package edu.upf.uploader;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.AmazonS3Exception;


public class S3Uploader implements Uploader {
    private final String bucket; //bucket name
    private final String prefix;
    private final AmazonS3 Client;
    
    public S3Uploader(String bucket, String prefix, AmazonS3 Client) {
        this.bucket = bucket;
        this.prefix = prefix;
        this.Client = Client;
    }

    public void bucketExists(){
        if(Client.doesBucketExistV2(bucket) == false){
            try {
                Client.createBucket(bucket);
            } catch (AmazonS3Exception e) {
                System.err.println(e.getErrorMessage());
            }
        }
        else {
            System.out.format("Bucket %s already exists.\n", bucket);
        }
    }

    @Override
    public void upload(List<String> files) throws IOException{
        for(int i = 0; i < files.size(); i++){
            try {
                Client.putObject(bucket, prefix + "/" + files.get(i), new File(files.get(i)));
            } catch (AmazonServiceException e) {
                System.err.println(e.getErrorMessage());
                System.exit(1);
                e.printStackTrace();
            }
            catch (SdkClientException e) {
                // Amazon S3 couldn't be contacted for a response, or the client
                // couldn't parse the response from Amazon S3.
                e.printStackTrace();
            }
        }
        
    }
}
