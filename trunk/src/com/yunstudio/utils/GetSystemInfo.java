package com.yunstudio.utils;

import java.io.File;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.lang.management.ManagementFactory;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.sun.management.OperatingSystemMXBean;

public class GetSystemInfo {
	
	public static final DecimalFormat nf=new DecimalFormat("#.0000");

    private static final int CPUTIME = 500;  
      
    private static final int PERCENT = 100;  
      
    private static final int FAULTLENGTH = 10;  
    
    public static final String JAVA_RUNTIME_NAME = "java.runtime.name";
    public static final String JAVA_VM_VERSION = "java.vm.version";
    public static final String JAVA_VM_VENDOR = "java.vm.vendor";
    public static final String JAVA_VENDOR_URL = "java.vendor.url";
    public static final String PATH_SEPARATOR = "path.separator";
    public static final String JAVA_VM_NAME = "java.vm.name";
    public static final String FILE_ENCODING_PKG = "file.encoding.pkg";
    public static final String USER_COUNTRY = "user.country";
    public static final String USER_SCRIPT = "user.script";
    public static final String JAVA_VM_SPECIFICATION_NAME = "java.vm.specification.name";
    public static final String USER_DIR = "user.dir";
    public static final String JAVA_RUNTIME_VERSION = "java.runtime.version";
    public static final String JAVA_AWT_GRAPHICSENV = "java.awt.graphicsenv";
    public static final String JAVA_ENDORSED_DIRS = "java.endorsed.dirs";
    public static final String OS_ARCH = "os.arch";
    public static final String JAVA_IO_TMPDIR = "java.io.tmpdir";
    public static final String LINE_SEPARATOR = "line.separator";
    public static final String JAVA_VM_SPECIFICATION_VENDOR = "java.vm.specification.vendor";
    public static final String USER_VARIANT = "user.variant";
    public static final String OS_NAME = "os.name";
    public static final String JAVA_LIBRARY_PATH = "java.library.path";
    public static final String JAVA_SPECIFICATION_NAME = "java.specification.name";
    public static final String JAVA_CLASS_VERSION = "java.class.version";
    public static final String OS_VERSION = "os.version";
    public static final String USER_HOME = "user.home";
    public static final String USER_TIMEZONE = "user.timezone";
    public static final String JAVA_AWT_PRINTERJOB = "java.awt.printerjob";
    public static final String FILE_ENCODING = "file.encoding";
    public static final String JAVA_SPECIFICATION_VERSION = "java.specification.version";
    public static final String JAVA_CLASS_PATH = "java.class.path";
    public static final String USER_NAME = "user.name";
    public static final String JAVA_VM_SPECIFICATION_VERSION = "java.vm.specification.version";
    public static final String JAVA_HOME = "java.home";
    public static final String USER_LANGUAGE = "user.language";
    public static final String JAVA_SPECIFICATION_VENDOR = "java.specification.vendor";
    public static final String AWT_TOOLKIT = "awt.toolkit";
    public static final String JAVA_VM_INFO = "java.vm.info";
    public static final String JAVA_VERSION = "java.version";
    public static final String JAVA_EXT_DIRS = "java.ext.dirs";
    public static final String JAVA_VENDOR = "java.vendor";
    public static final String FILE_SEPARATOR = "file.separator";
    public static final String JAVA_VENDOR_URL_BUG = "java.vendor.url.bug";
    
      
    /**
     * 获取内存使用率  
     * @return
     */
    public static String getMemeryRate()  
    {  
        OperatingSystemMXBean osmxb = (OperatingSystemMXBean)ManagementFactory.getOperatingSystemMXBean();  
        // 总的物理内存+虚拟内存  
        long totalvirtualMemory = osmxb.getTotalSwapSpaceSize();  
        // 剩余的物理内存  
        long freePhysicalMemorySize = osmxb.getFreePhysicalMemorySize();  
        Double compare = (Double)(1 - freePhysicalMemorySize * 1.0 / totalvirtualMemory) * 100;  
        String str = compare.intValue() + "%";  
        return str;  
    }  
    
	  /**
	   * 获取总共内存
	   * @return
	   */
	  public static Long getTotalMemery(){  
	      OperatingSystemMXBean osmxb = (OperatingSystemMXBean)ManagementFactory.getOperatingSystemMXBean();  
	      // 总的物理内存+虚拟内存  
	      return  osmxb.getTotalSwapSpaceSize();  
	  }  

	  /**
	   * 获取剩余内存
	   * @return
	   */
	  public static Long getLeftMemory(){
		  OperatingSystemMXBean osmxb=(OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
		  // 剩余的物理内存  
		  return osmxb.getFreePhysicalMemorySize();  
	  }
      
    /**
     * 获取文件系统使用率  
     * @return
     */
    public static List<String> getDisk()  
    {  
        // 操作系统  
        List<String> list = new ArrayList<String>();  
        for (char c = 'A'; c <= 'Z'; c++)  
        {  
            String dirName = c + ":/";  
            File win = new File(dirName);  
            if (win.exists())  
            {  
                long total = (long)win.getTotalSpace();  
                long free = (long)win.getFreeSpace();  
                String str = c + ":盘 总共:"+nf.format(total/(1024*1024*1024.0))+"G 可用:" + nf.format(free/(1024*1024*1024.0)) + "G";  
                list.add(str);  
            }  
        }  
        return list;  
    }  
    /**
     * 获取某个硬盘的使用情况  
     * @return
     */
    public static String getDisk(char c)  
    {  
        // 操作系统  
        List<String> list = new ArrayList<String>();  
        String dirName = c + ":/";  
        File win = new File(dirName);  
        if (win.exists())  
        {  
            long total = (long)win.getTotalSpace();  
            long free = (long)win.getFreeSpace();  
            String str = c + ":盘 总共:"+nf.format(total/(1024*1024*1024.0))+"G 可用:" + nf.format(free/(1024*1024*1024.0)) + "G";  
            return str;  
        }  else {
			return null;
		}
    } 
      
    /**
     * 获得cpu使用率  
     * @return
     */
    public static String getCpuRatioForWindows()  
    {  
        try  
        {  
            String procCmd =  
                System.getenv("windir")  
                    + "\\system32\\wbem\\wmic.exe process get Caption,CommandLine,KernelModeTime,ReadOperationCount,ThreadCount,UserModeTime,WriteOperationCount";  
            // 取进程信息  
            long[] c0 = readCpu(Runtime.getRuntime().exec(procCmd));  
            Thread.sleep(CPUTIME);  
            long[] c1 = readCpu(Runtime.getRuntime().exec(procCmd));  
            if (c0 != null && c1 != null)  
            {  
                long idletime = c1[0] - c0[0];  
                long busytime = c1[1] - c0[1];  
                return "CPU使用率:" + Double.valueOf(PERCENT * (busytime) * 1.0 / (busytime + idletime)).intValue() + "%";  
            }  
            else  
            {  
                return "CPU使用率:" + 0 + "%";  
            }  
        }  
        catch (Exception ex)  
        {  
            ex.printStackTrace();  
            return "CPU使用率:" + 0 + "%";  
        }  
    }  
      
    /**
     * 读取cpu相关信息  
     * @param proc
     * @return
     */
    private static long[] readCpu(final Process proc)  
    {  
        long[] retn = new long[2];  
        try  
        {  
            proc.getOutputStream().close();  
            InputStreamReader ir = new InputStreamReader(proc.getInputStream());  
            LineNumberReader input = new LineNumberReader(ir);  
            String line = input.readLine();  
            if (line == null || line.length() < FAULTLENGTH)  
            {  
                return null;  
            }  
            int capidx = line.indexOf("Caption");  
            int cmdidx = line.indexOf("CommandLine");  
            int rocidx = line.indexOf("ReadOperationCount");  
            int umtidx = line.indexOf("UserModeTime");  
            int kmtidx = line.indexOf("KernelModeTime");  
            int wocidx = line.indexOf("WriteOperationCount");  
            long idletime = 0;  
            long kneltime = 0;  
            long usertime = 0;  
            while ((line = input.readLine()) != null)  
            {  
                if (line.length() < wocidx)  
                {  
                    continue;  
                }  
                // 字段出现顺序：Caption,CommandLine,KernelModeTime,ReadOperationCount,  
                // ThreadCount,UserModeTime,WriteOperation  
                String caption = substring(line, capidx, cmdidx - 1).trim();  
                String cmd = substring(line, cmdidx, kmtidx - 1).trim();  
                if (cmd.indexOf("wmic.exe") >= 0)  
                {  
                    continue;  
                }  
                String s1 = substring(line, kmtidx, rocidx - 1).trim();  
                String s2 = substring(line, umtidx, wocidx - 1).trim();  
                if (caption.equals("System Idle Process") || caption.equals("System"))  
                {  
                    if (s1.length() > 0)  
                        idletime += Long.valueOf(s1).longValue();  
                    if (s2.length() > 0)  
                        idletime += Long.valueOf(s2).longValue();  
                    continue;  
                }  
                if (s1.length() > 0)  
                    kneltime += Long.valueOf(s1).longValue();  
                if (s2.length() > 0)  
                    usertime += Long.valueOf(s2).longValue();  
            }  
            retn[0] = idletime;  
            retn[1] = kneltime + usertime;  
            return retn;  
        }  
        catch (Exception ex)  
        {  
            ex.printStackTrace();  
        }  
        finally  
        {  
            try  
            {  
                proc.getInputStream().close();  
            }  
            catch (Exception e)  
            {  
                e.printStackTrace();  
            }  
        }  
        return null;  
    }  
      
    /** 
    * 由于String.subString对汉字处理存在问题（把一个汉字视为一个字节)，因此在 包含汉字的字符串时存在隐患，现调整如下： 
    * @param src 要截取的字符串 
    * @param start_idx 开始坐标（包括该坐标) 
    * @param end_idx 截止坐标（包括该坐标） 
    * @return 
    */  
    private static String substring(String src, int start_idx, int end_idx)  
    {  
        byte[] b = src.getBytes();  
        String tgt = "";  
        for (int i = start_idx; i <= end_idx; i++)  
        {  
            tgt += (char)b[i];  
        }  
        return tgt;  
    }
    
    /**
     * 获取信息属性
     * key为该类的静态常量
     * @param key
     * @return
     */
    public static String getProperty(String key) {
    	
		return System.getProperty(key);
		
	}
    
    public static void main(String[] args) {
    	
    	Properties props=System.getProperties(); 
    	
    	for (Map.Entry<Object, Object> e : props.entrySet()) {
			System.out.println("    private String "+e.getKey().toString().toLowerCase().replace(".", "_")+";");
		}
    	
    	System.out.println(getTotalMemery());
	}
    
}
