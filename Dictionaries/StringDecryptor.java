
import java.util.Base64;
import java.io.UnsupportedEncodingException;
import java.security.Key;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class StringDecryptor {
    private static String algorithm = "AES/ECB/PKCS5Padding";
    private static boolean development = false;
    private static String key = "anpkcmROQUc2TUZUTV81NypqeCE9eV50Y3hBWndxTTVoTlBIZlgyUDRWekUrTFNSeEpKOFZSbjNAQ2NKV04jWA==";
    private static String key2 = "";
    private static boolean open = true;

    public static String decrypt(String string2) {
        Cipher cipher;
        SecretKeySpec secretKeySpec;
        // Padding
        int n = 2 * StringDecryptor.generateKey2().length();
        // int n = 2 * 64;
        String string3 = "";
        // Len: 24
        for (int i = 0; i < string2.length(); ++i) {
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append(string3); // ""
            stringBuilder.append((char)(string2.charAt(i) - i % n)); 
            string3 = stringBuilder.toString();
        }
        string2 = string3;
        // System.out.println(string2);
        try {
            Base64.getDecoder().decode(string2);
        } catch(Exception e) {
            System.out.println(string2);
            return "Failed to decode";
        }
        
        // Decode String
        try {
            secretKeySpec = new SecretKeySpec(StringDecryptor.generateKey().getBytes("UTF8"), "AES");
            cipher = Cipher.getInstance(algorithm);

            cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
            return new String(cipher.doFinal(Base64.getDecoder().decode(string2)), "UTF8");
        }
        catch (Exception exception) {
            exception.printStackTrace();
            return "Error";
        }    
    }

    private static String generateKey() {
        try {
            String var1 = StringDecryptor.key;
            int var2_1 = 0;
            String var3_2 = new String(Base64.getDecoder().decode((String)var1), "UTF8");
            System.out.println(var3_2);
            
            String var4_3 = "";
            int var5_4 = var3_2.length() / 16; // 4
lbl9: // 2 sources:
            do {
                if (var2_1 >= var3_2.length()) return var4_3;
                if (var4_3.length() >= 16) {
                    return var4_3;
                }
                if (var2_1 % var5_4 == 0) {
                    StringBuilder var6_5 = new StringBuilder();
                    var6_5.append(var4_3);
                    var6_5.append(var3_2.charAt(var2_1));
                    var6_5.append("");
                    var4_3 = var6_5.toString();
                }
                
                ++var2_1;
            } while (true);
            
        }
        
        catch (UnsupportedEncodingException var0_6) {
            return "";
        }
        // return "";
        // ** while (true)
    }
    
    private static String generateKey2() {
        return new String(Base64.getDecoder().decode(key));
    }
    
    private static String hexToAscii(String hexStr) {
        StringBuilder output = new StringBuilder("");
         
        for (int i = 0; i < hexStr.length(); i += 2) {
            String str = hexStr.substring(i, i + 2);
            output.append((char) Integer.parseInt(str, 16));
        }
         
        return output.toString();
    }
    
    public static byte[] hexToBytes(String hex) {
        int l = hex.length();
        byte[] data = new byte[l/2];
        for (int i = 0; i < l; i += 2) {
            data[i/2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                                + Character.digit(hex.charAt(i+1), 16));
        }
        return data;
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
// byte[] bytes = javax.xml.bind.DatatypeConverter.parseHexBinary(hexString);
        // String hex = "756c793b49586a614c5264573d63434059796c555b7c5354";
        String hex = "697b37463b3a774a4f5b7f3c5b85467a895f3d82437c5354";
        String result = new String(hexToBytes(hex), "UTF8");
        // System.out.println("Converted: " + result);
        System.out.println("Result: " + decrypt(result));
        // System.out.println("Key: " + generateKey());
        // String hexString = "376855357e73677a6c7d503c6f5a77618764657c8a8e8d636f818e5150666e80906c716f8a6c209f6b907368";  
        // System.out.println("Abc: "+ decrypt(hexToAscii(hexString)));
        // System.out.println("Abc: "+ decrypt("I,ID]vsx^uTZwq~zLj{}tkwjgphx_}npr§¥¥o®¤µ»p½{£|¾§Ä¨¸¼¶ Äª´µËÅµ¢¬­¹ÕÕ¨"));
        // System.out.println("Abc: "+ decrypt("uly;IXjaLRdW=cC@YylU[|ST"));
    }
}
