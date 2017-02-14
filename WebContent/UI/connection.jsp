<%@page import="com.amazonaws.services.machinelearning.model.PredictResult"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.amazonaws.samples.machinelearning.RealtimePredict"%>
<% Class.forName("oracle.jdbc.OracleDriver"); %>
<%
String[] args=request.getParameterValues("datat[]");
RealtimePredict tt=new RealtimePredict(args[0]);
PredictResult str=tt.testr(args);
out.println(str.getPrediction().getPredictedValue().toString());
%>
 