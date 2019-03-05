package com.gd.controller.common;
import java.security.*;
import javax.crypto.*;

import org.apache.commons.codec.binary.Base64;
import sun.misc.*;
/**
 * Created by 郄梦岩 on 2017/11/15.
 */
public class Encrypt {

        private Key key;
        private byte[] byteMi = null;
        private byte[] byteMing = null;
        private String strMi= "";
        private String strM= "";
        //  根据参数生成KEY
        public void setKey(String strKey){
            try{
                KeyGenerator _generator = KeyGenerator.getInstance("DES");
                _generator.init(new SecureRandom(strKey.getBytes()));
                this.key = _generator.generateKey();
                _generator=null;
            }
            catch(Exception e){
                e.printStackTrace();
            }

        }
        //  加密String明文输入,String密文输出
        public String setEncString(String strMing){
            //BASE64Encoder base64en = new BASE64Encoder();

            try {

                this.byteMing = strMing.getBytes("UTF8");
                this.byteMi = this.getEncCode(this.byteMing);
                this.strMi = new String(Base64.encodeBase64(this.byteMi));
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            finally
            {

                this.byteMing = null;
                this.byteMi = null;
            }
            return this.strMi;
        }
        private byte[] getEncCode(byte[] byteS){
            byte[] byteFina = null;
            Cipher cipher;
            try
            {
                cipher = Cipher.getInstance("DES");
                cipher.init(Cipher.ENCRYPT_MODE,key);
                byteFina = cipher.doFinal(byteS);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            finally
            {
                cipher = null;
            }

            return byteFina;
        }
        // 解密:以String密文输入,String明文输出
        public String setDesString(String strMi){
            //BASE64Decoder base64De = new BASE64Decoder();
            try
            {
                this.byteMi = Base64.decodeBase64(strMi);
                this.byteMing = this.getDesCode(byteMi);
                this.strM = new String(byteMing,"UTF8");
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            finally
            {

                byteMing = null;
                byteMi = null;
            }
return this.strM;
        }
        // 解密以byte[]密文输入,以byte[]明文输出
        private byte[] getDesCode(byte[] byteD){
            Cipher cipher;
            byte[] byteFina=null;
            try{
                cipher = Cipher.getInstance("DES");
                cipher.init(Cipher.DECRYPT_MODE,key);
                byteFina = cipher.doFinal(byteD);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            finally
            {
                cipher=null;
            }
            return byteFina;
        }
        //返回加密后的密文strMi
        public String getStrMi()
        {
            return strMi;
        }
        //返回解密后的明文
        public String getStrM()
        {
            return strM;
        }
    }
