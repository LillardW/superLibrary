package fd;

import java.io.ByteArrayOutputStream;

import com.uhf.api.cls.Reader;
import com.uhf.api.cls.Reader.*;

public class RFIDapi {

	/**
	 * @param args
	 */

	int AntCount = 3;
	String ReaderAddr = "192.168.106.56";
	Reader Jreader;
	private static String hexString = "0123456789ABCDEF";

	public RFIDapi() {
		Jreader = new Reader();
	}

	public void testtran() {
		byte[] hex = new byte[] { (byte) 0xA2, (byte) 0xC8, (byte) 0xD4,
				(byte) 0xE5 };
		int len = 4;
		char[] str = new char[4 * 2];
		Jreader.Hex2Str(hex, len, str);
		String hstr = "";
		for (int i = 0; i < 8; i++)
			hstr += (char) str[i];
		System.out.println("test tohexstr:" + hstr);

		String buf = "0011110000001111";

		byte[] binarybuf = new byte[2];
		String buf2 = "abcdef08";
		byte[] hexbuf = new byte[4];
		Jreader.Str2Binary(buf, buf.length(), binarybuf);
		System.out.println("test binary:");
		for (int i = 0; i < binarybuf.length; i++)
			System.out.println(binarybuf[i]);

		Jreader.Str2Hex(buf2, 8, hexbuf);
		System.out.println("test hex:");
		for (int i = 0; i < hexbuf.length; i++)
			System.out.println(hexbuf[i]);
	}

	public void testcustomcmd() {
		// m4 qt
		IMPINJM4QtPara CustomPara = Jreader.new IMPINJM4QtPara();
		CustomPara.TimeOut = 800;
		CustomPara.CmdType = 1;
		CustomPara.MemType = 2;
		CustomPara.PersistType = 3;
		CustomPara.RangeType = 4;
		CustomPara.AccessPwd = new byte[] { 0x11, 0x22, 0x33, 0x44 };

		IMPINJM4QtResult CustomRet = Jreader.new IMPINJM4QtResult();
		Jreader.CustomCmd(1, CustomCmdType.IMPINJ_M4_Qt, CustomPara, CustomRet);

		// allen h3
		ALIENHiggs3BlockReadLockPara CustomPara2 = Jreader.new ALIENHiggs3BlockReadLockPara();
		CustomPara2.AccessPwd = new byte[] { 0x55, 0x66, 0x77, (byte) 0x88 };
		CustomPara2.BlkBits = 6;
		CustomPara2.TimeOut = 890;
		Jreader.CustomCmd(1, CustomCmdType.ALIEN_Higgs3_BlockReadLock,
				CustomPara2, null);

		// nexp eas
		NXPChangeEASPara CustomPara3 = Jreader.new NXPChangeEASPara();
		CustomPara3.AccessPwd = new byte[] { (byte) 0x99, (byte) 0xaa,
				(byte) 0xbb, (byte) 0xcc };
		CustomPara3.isSet = 1;
		CustomPara3.TimeOut = 900;
		Jreader.CustomCmd(1, CustomCmdType.NXP_ChangeEAS, CustomPara3, null);

		// nxp easl
		NXPEASAlarmPara CustomPara4 = Jreader.new NXPEASAlarmPara();
		CustomPara4.DR = 7;
		CustomPara4.MC = 11;
		CustomPara4.TimeOut = 950;
		CustomPara4.TrExt = 17;

		NXPEASAlarmResult CustomRet2 = Jreader.new NXPEASAlarmResult();
		Jreader.CustomCmd(1, CustomCmdType.NXP_EASAlarm, CustomPara4,
				CustomRet2);

		// basetype
		Jreader.CustomCmd_BaseType(1, 1, new byte[] { 0x11, (byte) 0x99,
				(byte) 0xbb }, new byte[] {});

	}

	public String testreadandwrite() {
		/*
		 * READER_ERR WriteTagData(int ant,char bank,int address, byte[] data,
		 * int datalen, byte[] accesspasswd,short timeout); ant �����ĵ����� bank ��ʾ����
		 * 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ data д������
		 * datalen ��ʾд�����ݳ��� accesspwd ��ʾ���룬Ĭ��"00000000" 8��ʮ�������ַ� timeout ������ʱʱ��
		 */

		String pwd = "12345678";
		 byte[] data=new byte[]{0x11,0x12,0x36,0x46,0x56,0x66,0x76,(byte)0x86,(byte)
		 0x96,(byte) 0xaa,(byte) 0xbb,(byte) 0xcc};
		byte[] pwdb = new byte[4];
		System.out.println("��Ҫд��������ǣ�");
		for (int i =0;i<data.length;i++){
			System.out.print(data[i]+" ");
		}
		
		Jreader.Str2Hex(pwd, pwd.length(), pwdb);
		// д����
		for(int i =0;i<pwdb.length;i++)
			System.out.println("д���ǩ���룺"+pwdb[i]);
		READER_ERR er =Jreader.WriteTagData(1, (char)1, 2, data, 12, null,
				 (short)10000);
		

		byte[] datar = new byte[12];
		// ������
		/*
		 * READER_ERR GetTagData(int ant,char bank, int address, int
		 * blkcnt,byte[] data, byte[] accesspasswd, short timeout); ant �����ĵ�����
		 * bank ��ʾ���� 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ
		 * blkcnt ��ʾ������ data ������ݵ��ֽڣ�Ӧ�ò�С��blkcnt*2 accesspwd ��ʾ���룬Ĭ��"00000000"
		 * 8��ʮ�������ַ� timeout ������ʱʱ��
		 * 
		 * String str1=""; er=Jreader.GetTagData(1, (char)1, 2, 6, datar, null,
		 * (short)1000);
		 * 
		 * for(int i=0;i<12;i++) { str1+=Integer.toHexString(datar[i]&0xff); }
		 * System.out.println(er.toString()+" "+str1.toUpperCase());
		 */
		String str1 = "";
		String str2 = "";
		/*
		 * byte[] data2=new byte[]{(byte)
		 * 0xFF,0x11,0x22,0x03,0x44,0x05,0x66,0x07,(byte) 0x88,(byte)
		 * 0x09,(byte) 0xaa,(byte) 0x0b}; er=Jreader.WriteTagEpcEx(1, data2, 12,
		 * null, (short)1000);
		 */
		 er = Jreader.GetTagData(1, (char) 1, 2, 6, datar, null, (short) 100000);

		for (int i = 0; i < 12; i++) {
			str1 += Integer.toHexString(datar[i] & 0xff);
			str2 +=Integer.toHexString(datar[i]);
			System.out.println("ԭʼ����λ��"+datar[i]);
		}
		System.out.println(er.toString() + " ��ȡ�������ݣ�" + str1.toUpperCase());
		System.out.println(er.toString() + " ��ȡ����ԭ���ݣ�" + str2.toUpperCase());
return str1.toUpperCase();
	}
	
	public String testreadandwrite1(byte[] data) {
		/*
		 * READER_ERR WriteTagData(int ant,char bank,int address, byte[] data,
		 * int datalen, byte[] accesspasswd,short timeout); ant �����ĵ����� bank ��ʾ����
		 * 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ data д������
		 * datalen ��ʾд�����ݳ��� accesspwd ��ʾ���룬Ĭ��"00000000" 8��ʮ�������ַ� timeout ������ʱʱ��
		 */

		String pwd = "12345678";
		// byte[] data=new byte[]{0x11,0x12,0x36,0x46,0x56,0x66,0x76,(byte)0x86,(byte)
		// 0x96,(byte) 0xaa,(byte) 0xbb,(byte) 0xcc};
		byte[] pwdb = new byte[4];
		System.out.println("��Ҫд��������ǣ�");
		for (int i =0;i<data.length;i++){
			System.out.print(data[i]+" ");
		}
		
		Jreader.Str2Hex(pwd, pwd.length(), pwdb);
		// д����
		for(int i =0;i<pwdb.length;i++)
			System.out.println("д���ǩ���룺"+pwdb[i]);
		READER_ERR er =Jreader.WriteTagData(1, (char)1, 2, data, 12, null,
				 (short)10000);
		

		byte[] datar = new byte[12];
		// ������
		/*
		 * READER_ERR GetTagData(int ant,char bank, int address, int
		 * blkcnt,byte[] data, byte[] accesspasswd, short timeout); ant �����ĵ�����
		 * bank ��ʾ���� 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ
		 * blkcnt ��ʾ������ data ������ݵ��ֽڣ�Ӧ�ò�С��blkcnt*2 accesspwd ��ʾ���룬Ĭ��"00000000"
		 * 8��ʮ�������ַ� timeout ������ʱʱ��
		 * 
		 * String str1=""; er=Jreader.GetTagData(1, (char)1, 2, 6, datar, null,
		 * (short)1000);
		 * 
		 * for(int i=0;i<12;i++) { str1+=Integer.toHexString(datar[i]&0xff); }
		 * System.out.println(er.toString()+" "+str1.toUpperCase());
		 */
		String str1 = "";
		String str2 = "";
		/*
		 * byte[] data2=new byte[]{(byte)
		 * 0xFF,0x11,0x22,0x03,0x44,0x05,0x66,0x07,(byte) 0x88,(byte)
		 * 0x09,(byte) 0xaa,(byte) 0x0b}; er=Jreader.WriteTagEpcEx(1, data2, 12,
		 * null, (short)1000);
		 */
		 er = Jreader.GetTagData(1, (char) 1, 2, 6, datar, null, (short) 100000);

		for (int i = 0; i < 12; i++) {
			str1 += Integer.toHexString(datar[i] & 0xff);
			str2 +=Integer.toHexString(datar[i]);
			System.out.println("ԭʼ����λ��"+datar[i]);
		}
		System.out.println(er.toString() + " ��ȡ�������ݣ�" + str1.toUpperCase());
		System.out.println(er.toString() + " ��ȡ����ԭ���ݣ�" + str2.toUpperCase());
return str1.toUpperCase();
	}
	public String testreadandwrite2(byte[] data) {
		/*
		 * READER_ERR WriteTagData(int ant,char bank,int address, byte[] data,
		 * int datalen, byte[] accesspasswd,short timeout); ant �����ĵ����� bank ��ʾ����
		 * 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ data д������
		 * datalen ��ʾд�����ݳ��� accesspwd ��ʾ���룬Ĭ��"00000000" 8��ʮ�������ַ� timeout ������ʱʱ��
		 */

		String pwd = "12345678";
		// byte[] data=new byte[]{0x11,0x12,0x36,0x46,0x56,0x66,0x76,(byte)0x86,(byte)
		// 0x96,(byte) 0xaa,(byte) 0xbb,(byte) 0xcc};
		byte[] pwdb = new byte[4];
		System.out.println("��Ҫд��������ǣ�");
		for (int i =0;i<data.length;i++){
			System.out.print(data[i]+" ");
		}
		
		Jreader.Str2Hex(pwd, pwd.length(), pwdb);
		// д����
		for(int i =0;i<pwdb.length;i++)
			System.out.println("д���ǩ���룺"+pwdb[i]);
		READER_ERR er =Jreader.WriteTagData(1, (char)1, 2, data, 12, null,
				 (short)10000);
		

		byte[] datar = new byte[12];
		// ������
		/*
		 * READER_ERR GetTagData(int ant,char bank, int address, int
		 * blkcnt,byte[] data, byte[] accesspasswd, short timeout); ant �����ĵ�����
		 * bank ��ʾ���� 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ
		 * blkcnt ��ʾ������ data ������ݵ��ֽڣ�Ӧ�ò�С��blkcnt*2 accesspwd ��ʾ���룬Ĭ��"00000000"
		 * 8��ʮ�������ַ� timeout ������ʱʱ��
		 * 
		 * String str1=""; er=Jreader.GetTagData(1, (char)1, 2, 6, datar, null,
		 * (short)1000);
		 * 
		 * for(int i=0;i<12;i++) { str1+=Integer.toHexString(datar[i]&0xff); }
		 * System.out.println(er.toString()+" "+str1.toUpperCase());
		 */
		String str1 = "";
		String str2 = "";
		/*
		 * byte[] data2=new byte[]{(byte)
		 * 0xFF,0x11,0x22,0x03,0x44,0x05,0x66,0x07,(byte) 0x88,(byte)
		 * 0x09,(byte) 0xaa,(byte) 0x0b}; er=Jreader.WriteTagEpcEx(1, data2, 12,
		 * null, (short)1000);
		 */
		 er = Jreader.GetTagData(1, (char) 1, 2, 6, datar, null, (short) 100000);

		for (int i = 0; i < 12; i++) {
			str1 += Integer.toHexString(datar[i] & 0xff);
			str2 +=Integer.toHexString(datar[i]);
			System.out.println("ԭʼ����λ��"+datar[i]);
		}
		System.out.println(er.toString() + " ��ȡ�������ݣ�" + str1.toUpperCase());
		System.out.println(er.toString() + " ��ȡ����ԭ���ݣ�" + str2.toUpperCase());
return str1.toUpperCase();
	}
	
    /*public void writetag(){// д���ݵ���ǩ
    	
    	String pwd = "12345678";
		 byte[] data=new byte[]{0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,(byte)
		 0x88,(byte) 0x99,(byte) 0xaa,(byte) 0xbb};
		byte[] pwdb = new byte[4];
		Jreader.Str2Hex(pwd, pwd.length(), pwdb);
		// д����  data Ϊд����
		
		READER_ERR er =Jreader.WriteTagData(1, (char)1, 2, data, 6, pwdb,
						 (short)1000);

		byte[] datar = new byte[12];
    	
    }*/
	
	public byte[] testreadandwrite3() {
		/*
		 * READER_ERR WriteTagData(int ant,char bank,int address, byte[] data,
		 * int datalen, byte[] accesspasswd,short timeout); ant �����ĵ����� bank ��ʾ����
		 * 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ data д������
		 * datalen ��ʾд�����ݳ��� accesspwd ��ʾ���룬Ĭ��"00000000" 8��ʮ�������ַ� timeout ������ʱʱ��
		 */

		String pwd = "12345678";
		 byte[] data=new byte[]{0x13,0x12,0x36,0x46,0x56,0x66,0x76,(byte)0x86,(byte)
		 0x96,(byte) 0xaa,(byte) 0xbb,(byte) 0xcc};
		byte[] pwdb = new byte[4];
		//System.out.println("3333��Ҫд��������ǣ�");
		for (int i =0;i<data.length;i++){
			//System.out.print(data[i]+" ");
		}
		
		Jreader.Str2Hex(pwd, pwd.length(), pwdb);
		// д����
		/*for(int i =0;i<pwdb.length;i++)
			System.out.println("д���ǩ���룺"+pwdb[i]);
		READER_ERR er =Jreader.WriteTagData(1, (char)1, 2, data, 12, null,
				 (short)10000);
		*/

		byte[] datar = new byte[12];
		// ������
		/*
		 * READER_ERR GetTagData(int ant,char bank, int address, int
		 * blkcnt,byte[] data, byte[] accesspasswd, short timeout); ant �����ĵ�����
		 * bank ��ʾ���� 0��ʾ������ 1��ʾepc�� 2��ʾtid�� 3��ʾuser�� address ��ʾ��ַ�飬 ע��epc���ӵڶ��鿪ʼ
		 * blkcnt ��ʾ������ data ������ݵ��ֽڣ�Ӧ�ò�С��blkcnt*2 accesspwd ��ʾ���룬Ĭ��"00000000"
		 * 8��ʮ�������ַ� timeout ������ʱʱ��
		 * 
		 * String str1=""; er=Jreader.GetTagData(1, (char)1, 2, 6, datar, null,
		 * (short)1000);
		 * 
		 * for(int i=0;i<12;i++) { str1+=Integer.toHexString(datar[i]&0xff); }
		 * System.out.println(er.toString()+" "+str1.toUpperCase());
		 */
		String str1 = "";
		String str2 = "";
		/*
		 * byte[] data2=new byte[]{(byte)
		 * 0xFF,0x11,0x22,0x03,0x44,0x05,0x66,0x07,(byte) 0x88,(byte)
		 * 0x09,(byte) 0xaa,(byte) 0x0b}; er=Jreader.WriteTagEpcEx(1, data2, 12,
		 * null, (short)1000);
		 */
		READER_ERR er = Jreader.GetTagData(1, (char) 1, 2, 6, datar, null, (short) 100000);

		for (int i = 0; i < 12; i++) {
			str1 += Integer.toHexString(datar[i] & 0xff);
			str2 +=Integer.toHexString(datar[i]);
			//System.out.println("ԭʼ����λ��"+datar[i]);
		}
		System.out.println(er.toString() + " ��ȡ�������ݣ�" + str1.toUpperCase());
		System.out.println(er.toString() + " ��ȡ����ԭ���ݣ�" + str2.toUpperCase());
		for (int i =0;i<datar.length;i++){
			System.out.print(datar[i]+"ceshi\n");
		}
return datar;
	}
	
	public void testblockop() {
		String pwd = "11000000";
		byte[] data = new byte[4];
		Jreader.Str2Hex(pwd, pwd.length(), data);
		// ������
		READER_ERR er = Jreader.BlockErase(1, (char) 1, 2, 12, data,
				(short) 1000);

		// ��������
		Jreader.BlockPermaLock(1, 1, 2, 6, new byte[] { (byte) 0xff,
				(byte) 0xff }, data, (short) 1000);

	}

	public void testinitreader() {
		// ������д��
		/*
		 * �������߿����Ӷ�д�� src �ǵ�ַ ip��ַ���ߴ��ں� rtype �����߿�����4�����ߴ���4 �������ͣ�READER_ERR
		 * ,MT_OK_ERR��ʾ������������ʾ����
		 */
		System.out.println("init......");
		READER_ERR er = Jreader
				.InitReader("com1", Reader_Type.MODULE_FOUR_ANTS);
		// READER_ERR er=Jreader.InitReader_Notype(ReaderAddr,AntCount);
		// yj ���� System.out.println(er.toString());

		/*
		 * ���������鹦�ʣ�AntPowerConf ��Ա�� AntPower���� antcnt��ʾ���߸��� AntPower���� antid ���ߺ�
		 * readPower ������ writePower д����
		 */

		AntPowerConf apcf = Jreader.new AntPowerConf();
		apcf.antcnt = AntCount;
		for (int i = 0; i < apcf.antcnt; i++) {
			AntPower jaap = Jreader.new AntPower();
			jaap.antid = i + 1;
			jaap.readPower = 2800;
			jaap.writePower = 2750;
			apcf.Powers[i] = jaap;
		}
		AntPowerConf apcf2 = Jreader.new AntPowerConf();
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_ANTPOWER, apcf);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_ANTPOWER, apcf2);
		System.out.println("count:......"+apcf2.antcnt);
		  for(int i=0;i<apcf2.antcnt;i++) {
		  System.out.print("antid:"+apcf2.Powers[i].antid);
		  System.out.print(" rp:"+apcf2.Powers[i].readPower);
		  System.out.print(" wp:"+apcf2.Powers[i].writePower);
		  System.out.println(); }
		 

		Inv_Potls_ST ipst = Jreader.new Inv_Potls_ST();
		ipst.potlcnt = 1;
		ipst.potls = new Inv_Potl[1];
		for (int i = 0; i < ipst.potlcnt; i++) {
			Inv_Potl ipl = Jreader.new Inv_Potl();
			ipl.weight = 30;
			ipl.potl = SL_TagProtocol.SL_TAG_PROTOCOL_GEN2;
			ipst.potls[0] = ipl;
		}

		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_INVPOTL, ipst);

		/*
		 * �����Ƿ������� ������ֵ����1��ʱ���ʾҪ��飬0��ʾ�����
		 */
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_READER_IS_CHK_ANT, 0);
	}

	public String testinventory1() {
		String str = " ";
		/*
		 * 
		 * ����Ƶ�ʣ�����ĳ��������Ƶ�ʱ��������Ч�� HoptableData_ST ����Ƶ�ʱ��� lenhtb ��ʾƵ�ʱ��� htb
		 * ����int���ͣ���ʾ����Ƶ�� HoptableData_ST hdst=Jreader.new HoptableData_ST();
		 * hdst.lenhtb=2; hdst.htb[0]=915250; hdst.htb[1]=915750;
		 * 
		 * READER_ERR
		 * er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_FREQUENCY_HOPTABLE,hdst);
		 */

		/*
		 * ants ��ѯʹ�õ����ߣ����������߿ڵ����� antcnt ʹ�õ����߸��� timeout ����ǩ��ʱ�� pTInfo ��ű�ǩ���ݵ�����
		 * tagcnt ��ű�ǩ�ĸ�����ֻ�贫��һ��Ԫ�ص�����
		 */
		int[] tagcnt = new int[1];
		TAGINFO[] taginfo = new TAGINFO[200];
		READER_ERR er = Jreader.TagInventory(new int[] { 1 }, 1, (short) 1000,
				taginfo, tagcnt);
		System.out.println(er);
		if (er == READER_ERR.MT_OK_ERR) {
			for (int i = 0; i < tagcnt[0]; i++) {
				str = Reader.bytes_Hexstr(taginfo[i].EpcId);
				// yj���� ��
				// System.out.println("inv1_epc:"+Reader.bytes_Hexstr(taginfo[i].EpcId));

			}
		}
		return str;
	}
	public void closeReader(){
		Jreader.CloseReader();
	}

	public void testinventory2() {
		int[] tagcnt = new int[1];
		TAGINFO taginfo = Jreader.new TAGINFO();
		READER_ERR er = Jreader.TagInventory_Raw(new int[] { 1 }, 1,
				(short) 1000, tagcnt);
		for (int i = 0; i < tagcnt[0]; i++) {
			er = Jreader.GetNextTag(taginfo);
			if (taginfo != null)
				System.out.println("inv2_epc:"
						+ Reader.bytes_Hexstr(taginfo.EpcId));
		}

		byte[] outbuf = new byte[800];

		er = Jreader.TagInventory_Raw(new int[] { 1 }, 1, (short) 1000, tagcnt);
		er = Jreader.GetNextTag_BaseType(outbuf);

	}

	public void testdataonreader() {
		byte[] data3 = new byte[100];
		READER_ERR er = Jreader.ReadDataOnReader(0, data3, 100);
		er = Jreader.SaveDataOnReader(0, data3, 100);

		// ������д��������
		er = Jreader.EraseDataOnReader();
	}

	public void testkilltag() {
		String pwd = "11000000";
		byte[] data = new byte[4];
		Jreader.Str2Hex(pwd, pwd.length(), data);
		READER_ERR er = Jreader.KillTag(1, data, (short) 1000);
	}

	public void testlocktag() {
		String pwd = "12340000";
		// READER_ERR er=Jreader.Lock180006BTag(1, 2, 6, (short) 1000);
		byte[] data = new byte[4];
		Jreader.Str2Hex(pwd, pwd.length(), data);

		// д����
		READER_ERR er = Jreader.WriteTagData(1, (char) 0, 2, data, 2, null,
				(short) 1000);
		er = Jreader.LockTag(1, (byte) Lock_Obj.LOCK_OBJECT_BANK1.value(),
				(short) Lock_Type.BANK1_LOCK.value(), data, (short) 1000);

		// д����
		er = Jreader.WriteTagData(1, (char) 1, 2, new byte[] { 0x11, 0x22 }, 2,
				null, (short) 1000);
		// yj���� ��System.out.println("no pwd write"+er.toString());

		// д����
		er = Jreader.WriteTagData(1, (char) 1, 2, new byte[] { 0x11, 0x22 }, 2,
				data, (short) 1000);
		// yj���� ��System.out.println("pwd write"+er.toString());

		er = Jreader.LockTag(1, (byte) Lock_Obj.LOCK_OBJECT_BANK1.value(),
				(short) Lock_Type.BANK1_UNLOCK.value(), data, (short) 1000);
	}

	public void testsetip() {
		Reader_Ip rip = Jreader.new Reader_Ip();
		/*
		 * rip.ip=new
		 * byte[]{'1','9','2','.','1','6','8','.','1','.','1','0','1'};
		 * rip.mask=new
		 * byte[]{'2','5','5','.','2','5','5','.','2','5','5','.','0'};
		 * rip.gateway=new
		 * byte[]{'1','9','2','.','1','6','8','.','1','.','2','5','4'}; //
		 */

		rip.ip = "192.168.106.31".getBytes();
		rip.mask = "255.255.255.0".getBytes();
		rip.gateway = "192.168.1.1".getBytes();
		// */

		READER_ERR er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_READER_IP, rip);

	}



	public byte[] getByteList(String str) {
		// ����Ĭ�ϱ����ȡ�ֽ�����
		byte[] bytes = str.getBytes();
		StringBuilder sb = new StringBuilder(bytes.length * 2);
		// ���ֽ�������ÿ���ֽڲ���2λ16��������
		for (int i = 0; i < bytes.length; i++) {
			sb.append(hexString.charAt((bytes[i] & 0xf0) >> 4));
			sb.append(hexString.charAt((bytes[i] & 0x0f) >> 0));
		}
		byte[] data = new byte[] { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
				0x30, 0x30, 0x30, 0x30, 0x30 };
		if (bytes.length >= 12) {
			for (int i = 0; i < data.length; i++) {
				data[i] = bytes[i];
			}
		} else {
			for (int i = 0; i < data.length; i++) {
				if (i < bytes.length) {
					data[i] = bytes[i];
				}
			}
		}
		return data;
	}



	public static String decode(String bytes) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream(
				bytes.length() / 2);
		// ��ÿ2λ16����������װ��һ���ֽ�
		for (int i = 0; i < bytes.length(); i += 2) {
			baos.write((hexString.indexOf(bytes.charAt(i)) << 4 | hexString
					.indexOf(bytes.charAt(i + 1))));
		}
		return removeTail0(new String(baos.toByteArray()));
	}

	public static String removeTail0(String str) {
		// ����ַ���β����Ϊ0�������ַ���
		if (!str.substring(str.length() - 1).equals("0")) {
			return str;
		} else {
			// �����ַ���β��ɾ��һλ�ٽ��еݹ�
			return removeTail0(str.substring(0, str.length() - 1));
		}
	}

	public void testrparams() {
		HoptableData_ST hdst = Jreader.new HoptableData_ST();
		hdst.lenhtb = 5;
		hdst.htb[0] = 915250;
		hdst.htb[1] = 916750;
		hdst.htb[2] = 917250;
		hdst.htb[3] = 925750;
		hdst.htb[4] = 926750;
		READER_ERR er = Jreader.ParamSet(
				Mtr_Param.MTR_PARAM_FREQUENCY_HOPTABLE, hdst);

		HoptableData_ST hdst2 = Jreader.new HoptableData_ST();
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_FREQUENCY_HOPTABLE, hdst2);
		/*
		 * //yj���� �� for(int i=0;i<hdst2.lenhtb;i++) {
		 * System.out.print("htb:"+i); System.out.println(" "+(hdst2.htb[i])); }
		 */

		//
		Region_Conf rcf1 = Region_Conf.RG_NA;
		Region_Conf[] rcf2 = new Region_Conf[1];

		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_FREQUENCY_REGION, rcf1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_FREQUENCY_REGION, rcf2);

		int[] val1 = new int[] { 250 };
		int[] val2 = new int[] { -1 };
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_BLF, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_BLF, val2);

		val1[0] = 496;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_MAXEPCLEN, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_MAXEPCLEN, val2);

		val1[0] = 10;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_Q, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_Q, val2);

		val1[0] = 2;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_SESSION, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_SESSION, val2);

		val1[0] = 2;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_TAGENCODING, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_TAGENCODING, val2);

		val1[0] = 1;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_TARGET, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_TARGET, val2);

		val1[0] = 3;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_TARI, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_TARI, val2);

		val1[0] = 1;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_GEN2_WRITEMODE, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_GEN2_WRITEMODE, val2);

		val1[0] = 2;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_ISO180006B_BLF, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_ISO180006B_BLF, val2);

		val1[0] = 1;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_ISO180006B_DELIMITER,
				val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_ISO180006B_DELIMITER,
				val2);

		val1[0] = 2;
		er = Jreader.ParamSet(
				Mtr_Param.MTR_PARAM_POTL_ISO180006B_MODULATION_DEPTH, val1);
		er = Jreader.ParamGet(
				Mtr_Param.MTR_PARAM_POTL_ISO180006B_MODULATION_DEPTH, val2);

		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_POTL_SUPPORTEDPROTOCOLS,
		// val1);
		// er=Jreader.ParamGet(Mtr_Param.MTR_PARAM_POTL_SUPPORTEDPROTOCOLS,
		// val2);

		val1[0] = 1;
		val2[0] = -1;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_POWERSAVE_MODE, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_POWERSAVE_MODE, val2);

		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_READER_AVAILABLE_ANTPORTS,
		// val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_READER_AVAILABLE_ANTPORTS,
				val2);

		ConnAnts_ST cast = Jreader.new ConnAnts_ST();
		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_READER_CONN_ANTS, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_READER_CONN_ANTS, cast);

		Reader_Ip rip2 = Jreader.new Reader_Ip();
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_READER_IP, rip2);
		/*
		 * //yj���� �� System.out.print("ip:"+rip2.ip.length+" ");
		 * System.out.println(new String(rip2.ip)); System.out.println(new
		 * String(rip2.mask)); System.out.println(new String(rip2.gateway));
		 */

		val1[0] = 1;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_READER_IS_CHK_ANT, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_READER_IS_CHK_ANT, val2);

		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_READER_VERSION, val1);
		// er=Jreader.ParamGet(Mtr_Param.MTR_PARAM_READER_VERSION, val2);

		AntPowerConf apcf = Jreader.new AntPowerConf();
		apcf.antcnt = 1;
		for (int i = 0; i < apcf.antcnt; i++) {
			AntPower jaap = Jreader.new AntPower();
			jaap.antid = i + 1;
			jaap.readPower = 2800;
			jaap.writePower = 2750;
			apcf.Powers[i] = jaap;
		}
		AntPowerConf apcf2 = Jreader.new AntPowerConf();
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_ANTPOWER, apcf);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_ANTPOWER, apcf2);
		/*
		 * //yj���� �� for(int i=0;i<apcf2.antcnt;i++) {
		 * System.out.print("antid:"+apcf2.Powers[i].antid);
		 * System.out.print(" rp:"+apcf2.Powers[i].readPower);
		 * System.out.print(" wp:"+apcf2.Powers[i].writePower);
		 * System.out.println(); }
		 */

		val1[0] = 100;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_HOPTIME, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_HOPTIME, val2);

		val1[0] = 1;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_LBT_ENABLE, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_LBT_ENABLE, val2);

		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_MAXPOWER, val1);
		short[] valso = new short[1];
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_MAXPOWER, valso);
		// yj���� ��System.out.println("max:"+valso[0]);

		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_MINPOWER, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_MINPOWER, valso);

		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_SUPPORTEDREGIONS, val1);
		// er=Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_SUPPORTEDREGIONS, val2);

		// er=Jreader.ParamSet(Mtr_Param.MTR_PARAM_RF_TEMPERATURE, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_RF_TEMPERATURE, val2);

		EmbededData_ST edst = Jreader.new EmbededData_ST();
		edst.startaddr = 0;
		edst.bank = 2;
		// bytecnt=0 ȡ��Ƕ������
		edst.bytecnt = 2;
		edst.accesspwd = null;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_EMBEDEDDATA, edst);

		EmbededData_ST edst2 = Jreader.new EmbededData_ST();
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TAG_EMBEDEDDATA, edst2);

		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_EMBEDEDDATA, null);

		EmbededSecureRead_ST esrst = Jreader.new EmbededSecureRead_ST();
		esrst.accesspwd = 1280;
		esrst.address = 2;
		esrst.ApIndexBitsNumInEpc = 1;
		esrst.ApIndexStartBitsInEpc = 3;
		esrst.bank = 1;
		// blkcnt =0 ȡ����
		esrst.blkcnt = 2;
		esrst.pwdtype = 1;
		esrst.tagtype = 2;
		EmbededSecureRead_ST esrst2 = Jreader.new EmbededSecureRead_ST();
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_EMDSECUREREAD, esrst);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TAG_EMDSECUREREAD, esrst2);
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_EMDSECUREREAD, null);

		TagFilter_ST tfst = Jreader.new TagFilter_ST();
		tfst.bank = 1;
		tfst.fdata = new byte[] { (byte) 0xE2, (byte) 0x00 };
		// flen 0 Ϊȡ������
		tfst.flen = 2;
		tfst.isInvert = 0;
		tfst.startaddr = 2;
		TagFilter_ST tfst2 = Jreader.new TagFilter_ST();

		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_FILTER, tfst);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TAG_FILTER, tfst2);
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_FILTER, null);

		Inv_Potls_ST ipst = Jreader.new Inv_Potls_ST();
		ipst.potlcnt = 1;
		ipst.potls = new Inv_Potl[1];
		for (int i = 0; i < ipst.potlcnt; i++) {
			Inv_Potl ipl = Jreader.new Inv_Potl();
			ipl.weight = 30;
			ipl.potl = SL_TagProtocol.SL_TAG_PROTOCOL_GEN2;
			ipst.potls[0] = ipl;
		}

		Inv_Potls_ST ipst2 = Jreader.new Inv_Potls_ST();
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_INVPOTL, ipst);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TAG_INVPOTL, ipst2);
		/*
		 * //yj���� �� for(int i=0;i<ipst2.potlcnt;i++)
		 * System.out.println(ipst2.potls[i].potl);
		 */

		val1[0] = 1;
		val2[0] = 0;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAG_SEARCH_MODE, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TAG_SEARCH_MODE, val2);

		val1[0] = 1;
		val2[0] = 0;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAGDATA_RECORDHIGHESTRSSI,
				val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TAGDATA_RECORDHIGHESTRSSI,
				val2);

		val1[0] = 1;
		val2[0] = 0;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TAGDATA_UNIQUEBYANT, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TAGDATA_UNIQUEBYANT, val2);

		val1[0] = 1;
		val2[0] = 0;
		er = Jreader
				.ParamSet(Mtr_Param.MTR_PARAM_TAGDATA_UNIQUEBYEMDDATA, val1);
		er = Jreader
				.ParamGet(Mtr_Param.MTR_PARAM_TAGDATA_UNIQUEBYEMDDATA, val2);

		val1[0] = 300;
		val2[0] = 0;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TRANS_TIMEOUT, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TRANS_TIMEOUT, val2);

		val1[0] = 1;
		val2[0] = 0;
		er = Jreader.ParamSet(Mtr_Param.MTR_PARAM_TRANSMIT_MODE, val1);
		er = Jreader.ParamGet(Mtr_Param.MTR_PARAM_TRANSMIT_MODE, val2);
	}

	public void testgpio() {
		READER_ERR er = Jreader.SetGPO(1, 1);
		er = Jreader.SetGPO(2, 0);
		er = Jreader.SetGPO(3, 0);
		er = Jreader.SetGPO(4, 1);

		int[] val = new int[1];
		er = Jreader.GetGPI(1, val);
		er = Jreader.GetGPI(2, val);
		er = Jreader.GetGPI(3, val);
		er = Jreader.GetGPI(4, val);
	}

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		RFIDapi mt = new RFIDapi();
		// ���Գ�ʼ��
		mt.testinitreader();
		// ����ת��
		// mt.testtran();
		// ����gpio
		// mt.testgpio();
		// ���Բ���
		// mt.testrparams();
		// ���Կ����
		// mt.testblockop();
		// ��������ָ��
		// mt.testcustomcmd();
		// ���Զ�д���ڲ�����
		// mt.testdataonreader();
		// �����̵㷽ʽ1
		//mt.testinventory1();
		// �����̵㷽ʽ2
		// mt.testinventory2();
		// ������������
		// mt.testkilltag();
		// ��������ǩ
		// mt.testlocktag();
		// ���Զ�д��ǩ
		mt.testreadandwrite3();
		// ���Ը�ip��ַ
		// mt.testsetip();
		// �رն�д��
	//	mt.write("0123456789AB");
		//System.out.println("data in tag: "+mt.read());
		mt.Jreader.CloseReader();
		System.out.println("test over");
	}
	/*
	 *YJ���� 2015-4-19 start
	 */
	public String write(String input) {
		testinitreader();
		String pwd = "12345678";
		// 10���ƻ�16���ƣ�������16����
		// ע���޸ĵ����鳤��datalen��WriteTagData()�����ĵ�5��������12Ϊȫ�����鳤��
		// byte[] data = new byte[] {0x68, 0x66, 0x30, 0x30, 0x31, 0x30, 0x30,
		// 0x30, 0x30, 0x30, 0x30, 0x30};
		byte[] data = getByteList(input);
		for(int i =0;i<data.length;i++)
			System.out.println(data[i]);
		byte[] pwdb = new byte[4];
		Jreader.Str2Hex(pwd, pwd.length(), pwdb);
		// д����
		READER_ERR er = Jreader.WriteTagData(1, (char) 1, 2, data, 12, null,
				(short) 10000);
		System.out.println("writetagdata:" + er.toString());
		byte[] datar = new byte[12];
		er = Jreader.GetTagData(1, (char) 1, 2, 6, datar, null, (short) 100000);
		String str1 = "";

		for (int i = 0; i < 12; i++) {
			String hc = Integer.toHexString(datar[i] & 0xff);
			str1 += hc;
			if (hc.length() < 2)
				str1 += "0";
		}
		System.out.println(er.toString() + " write result:"
				+ str1.toUpperCase());
		Jreader.CloseReader();
		return "";
		
	}
	
	public String read() {
		testinitreader();
		String pwd = "12345678";
		byte[] pwdb = new byte[4];
		Jreader.Str2Hex(pwd, pwd.length(), pwdb);
		byte[] datar = new byte[12];
		READER_ERR er = Jreader.GetTagData(1, (char) 1, 2, 6, datar, pwdb,
				(short) 100000);
		String str1 = "";
		for (int i = 0; i < 12; i++) {
			String hc = Integer.toHexString(datar[i] & 0xff);
			str1 += hc;
			if (hc.length() < 2)
				str1 += "0";
		}
		// System.out.println(er.toString() + " read result : :"
		// + str1.toUpperCase());
		Jreader.CloseReader();
		return decode(str1.toUpperCase());
	//	return "BP6cnsccdcdczFT42";
	}
	/*
	 *YJ���� 2015-4-19 end
	 */

}
