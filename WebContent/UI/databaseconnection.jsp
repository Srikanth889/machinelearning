        <% Class.forName("oracle.jdbc.OracleDriver"); %>
        <%@ page import="java.sql.*" %>
		<%@ page import="java.io.*"%>
         <script>
        function databaseImport(){
        	<%
        	java.sql.Connection conn = null;
			conn = DriverManager.getConnection("jdbc:oracle:thin:@172.25.1.81:1521/FEDRLDB", "CLMSURE", "RLKeGD$090");
			java.sql.Statement stmt = null;
        	 stmt = conn.createStatement() ;
        	 ResultSet resultset = stmt.executeQuery("SELECT * FROM OUT_CLAIMSJ_LDS_5_2014 WHERE rownum < 100") ;
		%>
   	  	<% while(resultset.next()){%>
   	  		var tablerow=new Array();
   	  		tablerow.push("<tr>");
   	  		tablerow.push("<td><input type='checkbox' name='checkrow'>&nbsp;"+<%= resultset.getString(1) %>+"</td>");
   	  		tablerow.push("<td>"+<%= resultset.getString(2) %>+"</td>");
   	  		tablerow.push("<td>"+<%= resultset.getString(3) %>+"</td>");
   	  		tablerow.push("<td>"+<%= resultset.getString(26) %>+"</td>");
   	  		tablerow.push("<td>"+<%= resultset.getString(13) %>+"</td>");
   	  		tablerow.push("</tr>");
   	  		var tablefullrow=tablerow.join('');
   	  		$('#dashboardtablebody').append(tablefullrow);
   		<% }%>
		$(".tablesorter").trigger("updateAll");
   	 };
     </script>
     
     		<div id="dashboardtablediv">
	     <!--   <table class="table-striped tablesorter" id="dashboardtable">
	        	<thead>
		            <tr>
		                <th><input type="checkbox" id="checkAll"/>&nbsp;BeneficiaryID</th>
		                <th>ClaimNumber</th>
		                <th>ProviderNumber</th>
		                <th>ClaimChargeAmount</th>
		                <th>ClaimPaidAmount</th>
		            </tr>
	            </thead>
	            <tbody id="dashboardtablebody">
		        </tbody>
	        </table>-->
	        <table class="table-striped tablesorter" id="dashboardtable" style="table-layout:fixed">
	        </table>
        </div>