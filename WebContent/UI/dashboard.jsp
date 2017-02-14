<%@page import="com.amazonaws.services.machinelearning.model.PredictResult"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.amazonaws.samples.machinelearning.RealtimePredict"%>
<% Class.forName("oracle.jdbc.OracleDriver"); %>
		<div class="row" style="margin-bottom:10px">
			<div class="col-xs-2 col-sm-2 col-md-2">
				<button type="button" class="btn btn-primary btn-sm" id="dashboardget">Calculate Selected</button>
			</div>
			<div class="col-xs-2 col-sm-2 col-md-2">	
				<button type="button" class="btn btn-primary btn-sm" id="dashboardclear">Reset</button>
			</div>
			<div class="col-xs-8 col-sm-8 col-md-8">
				<button type="button" class="btn btn-primary btn-sm" id="dashboardTableExport" style="float:right">Export Table</button>
			</div>
		</div>
		<div class="row" id="dashboardChartPanel" style="display:none;">
			<div class="col-xs-12 col-sm-12 col-md-12">
				<div class="panel panel-default">
					<div class="panel-body" id="container" style="height:420px"></div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12">
				<span id="tableTotalrows_filtered"></span>
			</div>
		</div>
		<div id="dashboardtablediv">
	        <table class="table-striped tablesorter" id="dashboardtable" style="table-layout:fixed">
	        </table>
        </div>
        <script>
        $('#dashboardTableExport').click(function(){
            // tell the output widget do it's thing
            $(".table-striped").trigger('outputTable');
        });
	        $('#dashboardget').click(function(e){
	            e.preventDefault();
	            if($('.checked').length){
		        	$.blockUI({
		        		css: { 
		        			border: 'none', 
		        			padding: '5px', 
		        			backgroundColor: '#000', 
		        			'-webkit-border-radius': '10px', 
		        			'-moz-border-radius': '10px', 
		        			opacity: .5, 
		        			color: '#fff' ,

		        			},
		        			message: '<i class="fa fa-spinner fa-spin fa-3x fa-fw" style="vertical-align:middle;"></i><h3 style="display:inline;vertical-align:middle;">Just a moment...</h3>',
		        			onBlock: function(){
		        				dashboardtables();
		        			}
		        	});
	            } else{
	            	alert("Please select atleast one")
	            }
	        });
	        $('#dashboardclear').click(function(e){
	            e.preventDefault();
	            var totalchildrenCount=$("#dashboardtable thead tr:not(.tablesorter-filter-row) th").length;
	            $('input[name="checkrow"]').prop('checked', false).trigger("change");
	            $('#checkAll').prop('checked', false).trigger("change");
				$("#dashboardtable tr:not(.tablesorter-filter-row) td:nth-child("+(totalchildrenCount-1)+")").text("NA");
				$("#dashboardtable tr:not(.tablesorter-filter-row) td:nth-child("+(totalchildrenCount)+")").text("NA");
				$("#container").empty();
				$("#dashboardChartPanel").hide();
	        });
	        $(".btn").mouseup(function(){
	            $(this).blur();
	        })
        	function dashboardtables(){
	        	var totalchildrenCount=$("#dashboardtable thead th").length;
	        	var ml_modelid="your AWS Model ID"//provide your model id for Amazon;
	        	var async_request=[];
				var dataRangeChart=new Array();
				var dataDifferenceChart=new Array();
	        	$('.checked').each(function(i, obj) {
	        		var row=this;
	        		var childrenCount=$(row).children().length;
	        		var actualamount=($(':nth-child('+(totalchildrenCount-2)+')', row).text().trim())*1;
	        		var datadashboard=new Array();
	        		datadashboard.push(ml_modelid);
					$(row).find("td").each(function(index,element){
						if((childrenCount-3)!=index){
							var thead=$("#dashboardtable thead").find('th').eq(index).text();
							var tdata=$(this).text();
							var datafield=thead.trim()+"="+tdata.trim();
							datadashboard.push(datafield)
						} else {
							return false;
						}
					});
					async_request.push(
						$.ajax({
		       	            type : "POST",
		       	            url : "connection.jsp",
		       	         	data:{datat:datadashboard},
		       	         	dataType:"json",
		       	            success : function(data) {
		       					$(':nth-child('+(totalchildrenCount-1)+')', row).text(data);
		       					var difference=((data-actualamount)/actualamount)*100;
		       					difference=difference.toFixed(2);
		       					$(':nth-child('+(totalchildrenCount)+')', row).text(difference+" %");
		       	            },
		       	            complete:function(){
		       	            }
	       	        	})
	       	        );
					
	        	});
	        	$.when.apply(null, async_request).done( function(){
	        		
	        	    // all done
	        		var categories_0=[];
	        		var categories_1=[];
	        		var categories_2=[];
	        		var categories_3=[];
	        		var categories_4=[];
	        		var categories_5=[];
	        		var categories_6=[];
		        	var actualvaluesChart_0=[];
		        	var actualvaluesChart_1=[];
		        	var actualvaluesChart_2=[];
		        	var actualvaluesChart_3=[];
		        	var actualvaluesChart_4=[];
		        	var actualvaluesChart_5=[];
		        	var actualvaluesChart_6=[];
		        	var predictedvaluesChart_0=[];
		        	var predictedvaluesChart_1=[];
		        	var predictedvaluesChart_2=[];
		        	var predictedvaluesChart_3=[];
		        	var predictedvaluesChart_4=[];
		        	var predictedvaluesChart_5=[];
		        	var predictedvaluesChart_6=[];
		        	var total=0;
		        	//var outliers=0;
		        	//var good=0;
		        	//var others=0;
		        	var id_0=0;
		        	var id_1=0;
		        	var id_2=0;
		        	var id_3=0;
		        	var id_4=0;
		        	var id_5=0;
		        	var id_6=0;
	        		$('.checked').each(function(i, obj) {
		        		var row=this;
       					var category=$(':nth-child(1)', row).text()+"_"+$(':nth-child(2)', row).text();
		        		var actualamount=($(':nth-child('+(totalchildrenCount-2)+')', row).text().trim())*1;
		        		var predictedamount=($(':nth-child('+(totalchildrenCount-1)+')', row).text().trim())*1;
       					var difference=((predictedamount-actualamount)/actualamount)*100;
       					difference=Math.abs(difference.toFixed(2)*1);
       					total++;
       					//if(difference>30){outliers++};
       					//if(difference<10){good++};
       					switch(true){
	       					case difference <= 5:
	       						id_0++;
	       						categories_0.push(category);
	       						actualvaluesChart_0.push(actualamount);
	       						predictedvaluesChart_0.push(predictedamount);
	       						break;
	       					case difference > 5 && difference <= 10:
	       						id_1++;
	   							categories_1.push(category);
	       						actualvaluesChart_1.push(actualamount);
	       						predictedvaluesChart_1.push(predictedamount);	
	       						break;
	       					case difference > 10 && difference <= 15:
	       						id_2++;
	   							categories_2.push(category);
	       						actualvaluesChart_2.push(actualamount);
	       						predictedvaluesChart_2.push(predictedamount);
	       						break;
	       					case difference > 15 && difference <= 30:
	       						id_3++;
	   							categories_3.push(category);
	       						actualvaluesChart_3.push(actualamount);
	       						predictedvaluesChart_3.push(predictedamount); 
	       						break;
	       					case difference > 30 && difference <= 50:
	       						id_4++;
	   							categories_4.push(category);
	       						actualvaluesChart_4.push(actualamount);
	       						predictedvaluesChart_4.push(predictedamount);	
	       						break;
	       					case difference > 50 && difference <= 100:
	      						id_5++;
	   							categories_5.push(category);
	       						actualvaluesChart_5.push(actualamount);
	       						predictedvaluesChart_5.push(predictedamount);
	       						break;
	       					case difference > 100:
	      						id_6++;
   								categories_6.push(category);
       							actualvaluesChart_6.push(actualamount);
       							predictedvaluesChart_6.push(predictedamount);
       							break;
       					}
       				});
	        		//others=total-outliers-good;		        	
		        	var datasetTree=[
		        	                 {id:"id_0",name:"0% - 5%",value:id_0,color:"#90ed7d",dataCategory:categories_0,dataActual:actualvaluesChart_0,dataPredicted:predictedvaluesChart_0},
		        	                 {id:"id_1",name:"5% - 10%",value:id_1,color:"#91e8e1",dataCategory:categories_1,dataActual:actualvaluesChart_1,dataPredicted:predictedvaluesChart_1},
		        	                 {id:"id_2",name:"10% - 15%",value:id_2,color:"#7cb5ec",dataCategory:categories_2,dataActual:actualvaluesChart_2,dataPredicted:predictedvaluesChart_2},
		        	                 {id:"id_3",name:"15% - 30%",value:id_3,color:"#e4d354",dataCategory:categories_3,dataActual:actualvaluesChart_3,dataPredicted:predictedvaluesChart_3},
		        	                 {id:"id_4",name:"30% - 50%",value:id_4,color:"#f7a35c",dataCategory:categories_4,dataActual:actualvaluesChart_4,dataPredicted:predictedvaluesChart_4},
		        	                 {id:"id_5",name:"50% - 100%",value:id_5,color:"#f15c80",dataCategory:categories_5,dataActual:actualvaluesChart_5,dataPredicted:predictedvaluesChart_5},
		        	                 {id:"id_6",name:"Above 100%",value:id_6,color:"#f45b5b",dataCategory:categories_6,dataActual:actualvaluesChart_6,dataPredicted:predictedvaluesChart_6}
		        	                ];
	        		dashboardChart(datasetTree, total);
	        		
	        	});
	        }
        </script>
        <script>
        function csvImport(){
        	var tablerow=new Array();
            <% 
            String fName = "your csvfilename" //provide csv filename here;
            String thisLine; 
            int count=0; 
            FileInputStream fis = new FileInputStream(fName);
            DataInputStream myInput = new DataInputStream(fis);
            int i=0; 
            %>
            <%
            while ((thisLine = myInput.readLine()) != null)
           {
	            String strar[] = thisLine.split(",");
	        	if(i==0){%>
	        	tablerow.push("<thead>");
	        	<%} else if (i==1){%>
	        	tablerow.push("<tbody>");
	        	<%}%>
	        	tablerow.push("<tr>");
	        	<%
	            for(int j=0;j<strar.length;j++)
	            {
		            String data=(strar[j]).toString();
		            if(i!=0)
		            { 
		            	if(j!=0){%>
		        			tablerow.push("<td title='<%=data%>'><%=data%></td>");
		            	<%} else{%>
		            		tablerow.push("<td title='<%=data%>'><input type='checkbox' name='checkrow'> <%=data%></td>");
		            	<%}
		            }
		            else //header elements
		            {
		            	if(j!=0){%>
		    				tablerow.push("<th title='<%=data%>'><%=data%></th>");
		        		<%} else{%>
		        			tablerow.push("<th title='<%=data%>'><input type='checkbox' id='checkAll'/> <%=data%></th>");
		        		<%}
		            }
	            }
	        	if(i==0){%>
	        		tablerow.push("<th>PREDICTED_AMT</th>");
	        		tablerow.push("<th>DIFFERENCE_PRCNTG</th>");
	        		tablerow.push("</tr>");
	        		tablerow.push("</thead>");
	        	<%} 
	        	else{%>
	        		tablerow.push("<td>NA</td>");
	        		tablerow.push("<td>NA</td>");
	        		tablerow.push("</tr>");
	        	<%}
	        	if(i==1){%>
	        		
	        	<%}
	        	i++;}%>
	        	tablerow.push("</tbody>");
        	var tablefullrow=tablerow.join('');
        	$('#dashboardtable').append(tablefullrow);
        	$("#dashboardtable td:last-child").addClass("sorter-percent");
			$(".tablesorter").trigger("updateAll");
        }
     </script>
     <script>
     function dashboardChart(datasetTree,total){
	    Highcharts.setOptions({
   			lang: {
   				thousandsSep: ',',
   			}
    	 });
    	 $('#container').empty();
    	 $("#dashboardChartPanel").show();
	    	 $("#container").highcharts({
	    		    series: [{
	    		        type: 'treemap',
	    		        layoutAlgorithm: 'squarified',
	    		        allowDrillToNode: false,
	    		        animationLimit: 1000,
	    		        dataLabels: {
	    		            enabled: true
	    		        },
	    		        levelIsConstant: false,
	    		        levels: [{
	    		            level: 1,
	    		            dataLabels: {
	    		                enabled: true,
	    		                formatter:function(){
	    		                	var numberObservations=this.point.dataCategory.length;
	    		                	var percentage=Math.round(((numberObservations)/total)*100);
	    		                	if(percentage>5){
		    		                	return "<span style='font-size:150%'>"+this.point.name+"</span><span>&nbsp;&nbsp;("+percentage+"%)</span>"
	    		                	} else {
		    		                	return "<span>"+this.point.name+"</span><span>&nbsp;&nbsp;("+percentage+"%)</span>"
	    		                	}
	    		                },
	    		                useHTML:true
	    		            },
	    		            borderWidth: 3
	    		        }],
	    		        data: datasetTree
	    		    }],
	    		    subtitle: {
	    		        text: ''
	    		    },
	    		    title: {
	    		        text: 'Deviation of Predicted Amount from Actual Amount - Total Selected:'+total
	    		    },
	    		    tooltip: {
	    		        enabled: true,
	    		        formatter:function(){
	    		        	var numberObservations=this.point.dataCategory.length;
		                	var percentage=Math.round(((numberObservations)/total)*100);
		                	return "<span style='font-size:15px'>"+this.point.name+"</span><br><span>Percentage of Selected: "+percentage+"%</span><br><span>Number of Claims: "+numberObservations+"</span>"
	    		        	
	    		        }
	    		    },
	    	        plotOptions: {
	    	                series: {
	    	                    cursor: 'pointer',
	    	                    point: {
	    	                        events: {
	    	                            click: function() {
	    	                            	getSelectedVariationChart(this.dataCategory,this.dataActual,this.dataPredicted,this.name,datasetTree,total)
	    	                            }
	    	                        }
	    	                    }
	    	                }
	    	            }
	    		});
    	 	
    	 	$("#container").highcharts().reflow();
    	 	;
    	 };
     </script>
     <script>
     function getSelectedVariationChart(categories,actualvaluesChart,predictedvaluesChart,name,datasetTree,total){
 	    Highcharts.setOptions({
   			lang: {
   				thousandsSep: ',',
   				customKey_Hide:"Click to see the Deviation tree map"
   			}
    	 });
    	$('#container').empty();
     	$("#container").highcharts({
		 chart:{
			 zoomType: 'x'
		 },
    	 title: {
    	        text: 'Claim Payment Amount Prediction for '+name,
    	        x: -20 //center
    	    },
    	    subtitle: {
    	        text: '',
    	        x: -20
    	    },
    	    xAxis: {
    	    	crosshair: true,
    	    	categories:categories
    	    },
    	    yAxis: {
    	        title: {
    	            text: 'Claim Amount'
    	        },
    	        plotLines: [{
    	            value: 0,
    	            width: 1,
    	            color: '#808080'
    	        }]
    	    },
                tooltip: {
   					enabled:true,
   		            shared: true,
   		         	valuePrefix: '$',
   		         	valueDecimals: 2
                },
    	    legend: {
    	        layout: 'vertical',
    	        align: 'right',
    	        verticalAlign: 'middle',
    	        borderWidth: 0
    	    },
    	    series: [{
    	        name: 'Actual Amount',
    	        data: actualvaluesChart,
    	        color:'#00b300'
    	    }, {
    	        name: 'Predicted Amount',
    	        data: predictedvaluesChart,
    	        dashStyle:'dashdot',
    	        color: '#B7410E'
    	    }],
    		exporting: {
    		    buttons: {
                    customButton: {
                        text: 'Go Back',
                        _titleKey: "customKey_Hide",
                        
                        theme: {
                            'stroke-width': 1,
                            stroke: 'silver',
                            r: 0,
                            states: {
                                hover: {
                                    fill: '#a4edba'
                                },
                                select: {
                                    stroke: '#039',
                                    fill: '#a4edba'
                                }
                            }
                        },
                        onclick: function () {
                        	dashboardChart(datasetTree,total);
                        }
                    },
                    contextButton: {
                        	menuItems: [{
    							textKey: 'printChart',
    							onclick: function () {
    							this.print();
    							}
    						},{
                                textKey: 'downloadCSV',
                                onclick: function () {
                                    this.downloadCSV();
                                }
                            },{
                                textKey: 'downloadPNG',
                                onclick: function () {
                                    this.exportChart();
                                }
                            }]
                    }
                },
                chartOptions: {
                    plotOptions: {
                        series: {
                            dataLabels: {
                                enabled: false
                            }
                        }
                    }
                }
            }
    	 });
	 	$("#container").highcharts().reflow();
     }
     </script>
