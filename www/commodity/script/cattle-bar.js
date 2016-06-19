        // configure for module loader
        require.config({
            paths: {
                echarts: '/echarts-2.2.7/build/dist'
            }
        });
        
        // use
        require(
            [
                'echarts',
                'echarts/chart/bar' // require the specific chart type
            ],
            function (ec) {
                // Initialize after dom ready
                var myChart = ec.init(document.getElementById('cattle-bar')); 
                
                var option = {
                    tooltip: {
                        show: true
                    },
                    legend: {
                        data:['Sales']
                    },
		toolbox: {
		        show : false,
     		   feature : {
  		          mark : {show: true},
		          dataView : {show: true, readOnly: false},
       		          magicType : {show: true, type: ['line', 'bar']},
   		          restore : {show: true},
         	          saveAsImage : {show: true}
                   }
                },
                    xAxis : [
                        {
                            type : 'category',
                            data : ["Shirts", "Sweaters", "Chiffon Shirts", "Pants", "High Heels", "Socks"]
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    series : [
                        {
                            "name":"Sales",
                            "type":"bar",
                            "data":[5, 20, 40, 10, 10, 20]
                        }
                    ]
                };
        
                // Load data into the ECharts instance 
                myChart.setOption(option); 
            }
        );

