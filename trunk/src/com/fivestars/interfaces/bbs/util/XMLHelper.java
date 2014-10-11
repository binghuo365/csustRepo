package com.fivestars.interfaces.bbs.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.util.LinkedList;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.sun.org.apache.xerces.internal.parsers.DOMParser;
import com.sun.org.apache.xerces.internal.xni.parser.XMLInputSource;

/**
 * ================================================
 * Discuz! Ucenter API for JAVA
 * ================================================
 * XML工具类，处理UC Client接收到返回结果。
 * UC Client会收到UC Server返回的XML结果
 * 该类将XML中的数据提取成一个List按顺序读取即可。
 * 
 * 更多信息：http://code.google.com/p/discuz-ucenter-api-for-java/
 * 作者：梁平 (no_ten@163.com) 
 * 创建时间：2009-2-20
 */
public class XMLHelper {

	public static LinkedList<String> uc_unserialize(String input){
		
		LinkedList<String> result = new LinkedList<String>();
		
		DOMParser parser = new DOMParser();
		try {			
			parser.parse(new InputSource(new StringReader(input)));
			Document doc = parser.getDocument();
			NodeList nl = doc.getChildNodes().item(0).getChildNodes();
			int length = nl.getLength();
			for(int i=0;i<length;i++){
				if(nl.item(i).getNodeType()==Document.ELEMENT_NODE)
					result.add(nl.item(i).getTextContent());
			}
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
}
