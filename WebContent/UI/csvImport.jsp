<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<% 
	String args[]=request.getParameterValues("dataSet[]");
	File csvFilename = new File(args[0]); 
	FileReader fr = new FileReader(csvFilename);
	BufferedReader br = new BufferedReader(fr);
    try {
            String strline;
            StringBuffer output = new StringBuffer();
     		int count=0; 
      		int i=0; 
    		while((strline=br.readLine())!=null)
     		{
       			String strar[] = strline.split(",");
   				if(i==0){
   					out.println("<thead>");
   				} else if (i==1){
   					out.println("<tbody>");
   				}
   				out.println("<tr>");
       			for(int j=0;j<strar.length;j++)
       			{
        			String data=(strar[j]).toString().replace("\"", "");
	       			if(i!=0)
	        		{ 
	        			if(j!=0){
	    					out.println("<td title='"+data+"'>"+data+"</td>");
	        			} else{
	        				out.println("<td title='"+data+"'><input type='checkbox' name='checkrow'>"+data+"</td>");	
	        			}
	        		}
	        		else //header elements
	        		{
	        			if(j!=0){
	        				out.println("<th title='"+data+"'>"+data+"</th>");
	    				} else{
	    					out.println("<th title='"+data+"'><input type='checkbox' id='checkAll'>"+data+"</th>");
	    				}
	        		}
       			}
   				if(i==0){
   					out.println("<th>PREDICTED_AMT</th>");
   					out.println("<th>DIFFERENCE_PRCNTG</th>");
   					out.println("</tr>");
   					out.println("</thead>");
   				} 
   				else{
   					out.println("<td>NA</td>");
   					out.println("<td>NA</td>");
   					out.println("</tr>");
   				}
   				i++;
   			}
	}
    finally {
       br.close();
       fr.close();
 	}
    out.println("</tbody>");
%>
