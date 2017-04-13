package fd;
import java.util.HashMap;
import java.util.Map;


public class t {
	public static void main(String[] args) {
        HexToDec("bb" 
        		);
    }
 
    /**
     * 将十六进制的字符串转化为十进制的数值
     */
    public static long HexToDec(String hexStr) {
        Map<String, Integer> hexMap = prepareDate(); // 先准备对应关系数据
        int length = hexStr.length();
        long result = 0L; // 保存最终的结果
        for (int i = 0; i < length; i++) {
            result += hexMap.get(hexStr.subSequence(i, i + 1)) * Math.pow(16, length - 1 - i);
        }
        System.out.println("hexStr=" + hexStr + ",result=" + result);
        return result;
    }
 
    /**
     * 准备十六进制字符对应关系。如("1",1)...("A",10),("B",11)
     */
    private static HashMap<String, Integer> prepareDate() {
        HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
        for (int i = 1; i <= 9; i++) {
            hashMap.put(i + "", i);
        }
        hashMap.put("A", 10);
        hashMap.put("B", 11);
        hashMap.put("C", 12);
        hashMap.put("D", 13);
        hashMap.put("E", 14);
        hashMap.put("F", 15);
        
        return hashMap;
    }
}
