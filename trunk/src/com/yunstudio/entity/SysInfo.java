package com.yunstudio.entity;

public class SysInfo {
	private String osinfo;
	private String cpuType;
	private String sysUser;
	private String tomCatDir;
	private String tomCatTempDir;
	private String javaRuntimeNameInfo;
	private String javaVmInfo;
	private String totalMemory;
	private String leftMemory;
	private String usingMemory;
	private String diskInfo;
	public String getOsinfo() {
		return osinfo;
	}
	public void setOsinfo(String osinfo) {
		this.osinfo = osinfo;
	}
	public String getCpuType() {
		return cpuType;
	}
	public void setCpuType(String cpuType) {
		this.cpuType = cpuType;
	}
	public String getSysUser() {
		return sysUser;
	}
	public void setSysUser(String sysUser) {
		this.sysUser = sysUser;
	}
	public String getTomCatDir() {
		return tomCatDir;
	}
	public void setTomCatDir(String tomCatDir) {
		this.tomCatDir = tomCatDir;
	}
	public String getTomCatTempDir() {
		return tomCatTempDir;
	}
	public void setTomCatTempDir(String tomCatTempDir) {
		this.tomCatTempDir = tomCatTempDir;
	}
	public String getJavaRuntimeNameInfo() {
		return javaRuntimeNameInfo;
	}
	public void setJavaRuntimeNameInfo(String javaRuntimeNameInfo) {
		this.javaRuntimeNameInfo = javaRuntimeNameInfo;
	}
	public String getJavaVmInfo() {
		return javaVmInfo;
	}
	public void setJavaVmInfo(String javaVmInfo) {
		this.javaVmInfo = javaVmInfo;
	}
	public String getTotalMemory() {
		return totalMemory;
	}
	public void setTotalMemory(String totalMemory) {
		this.totalMemory = totalMemory;
	}
	public String getLeftMemory() {
		return leftMemory;
	}
	public void setLeftMemory(String leftMemory) {
		this.leftMemory = leftMemory;
	}
	public String getDiskInfo() {
		return diskInfo;
	}
	public void setDiskInfo(String diskInfo) {
		this.diskInfo = diskInfo;
	}
	public String getUsingMemory() {
		return usingMemory;
	}
	public void setUsingMemory(String usingMemory) {
		this.usingMemory = usingMemory;
	}
}
