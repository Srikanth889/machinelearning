<title>LDS Machine Learning</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.27.8/css/theme.blue.css" />
        <link rel="stylesheet" href="./CSS/main.css" type="text/css"/>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.28.5/js/jquery.tablesorter.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.28.5/js/jquery.tablesorter.widgets.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.27.8/js/widgets/widget-output.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.blockUI/2.70/jquery.blockUI.min.js"></script>
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/highcharts-more.js"></script>
		<script src="https://code.highcharts.com/modules/treemap.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="http://highcharts.github.io/export-csv/export-csv.js"></script>
        <script type="text/javascript">
        	$(document).ajaxStop($.unblockUI);
	        $(document).ready(function() 
	        	    { 
			        	csvImport();
		            	 $(document).on('change', 'input[name="checkrow"]', function() {
		    	        	  $(this).parent().toggleClass('yellow', $(this).is(':checked'));
		    	        	  $(this).parent().siblings().toggleClass('yellow', $(this).is(':checked'));
		    	        	  $(this).parent().parent().toggleClass('checked', $(this).is(':checked'));
			        	  });
			        	 $(document).on('change', '#checkAll', function() {
			        	   	  $('input[name="checkrow"]').prop('checked', $(this).prop("checked")).trigger("change");
			        	});
	        	    } 
	        	); 
        </script>
