package fd;
import java.util.HashMap;
import java.util.Map;


public class t {
	public static void main(String[] args) {
        HexToDec("bb" 
        		);
    }
 
    /**
     * ��ʮ�����Ƶ��ַ���ת��Ϊʮ���Ƶ���ֵ
     */
    public static long HexToDec(String hexStr) {
        Map<String, Integer> hexMap = prepareDate(); // ��׼����Ӧ��ϵ����
        int length = hexStr.length();
        long result = 0L; // �������յĽ��
        for (int i = 0; i < length; i++) {
            result += hexMap.get(hexStr.subSequence(i, i + 1)) * Math.pow(16, length - 1 - i);
        }
        System.out.println("hexStr=" + hexStr + ",result=" + result);
        return result;
    }
 
    /**
     * ׼��ʮ�������ַ���Ӧ��ϵ����("1",1)...("A",10),("B",11)
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
