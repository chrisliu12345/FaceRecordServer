package com.gd.util;


import ws.schild.jave.*;

import java.io.File;

/**
 * @author qiemengyan
 * @since 2018年11月22日
 * 
 *        将任何音频转换为mp3
 */
public class AnyAudioToMp3 {

	public static void WavToMp3Test(String path,String tmp) {

		File source = new File(tmp);
		MultimediaObject msource = new MultimediaObject(source);

		File target = new File(path);

		AudioAttributes audio = new AudioAttributes();
		audio.setCodec("libmp3lame");
		audio.setBitRate(new Integer(128000));
		audio.setChannels(new Integer(2));
		audio.setSamplingRate(new Integer(44100));

		EncodingAttributes attrs = new EncodingAttributes();
		attrs.setFormat("mp3");
		attrs.setAudioAttributes(audio);

		Encoder encoder = new Encoder();
		try {
			encoder.encode(msource, target, attrs);

		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InputFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (EncoderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}