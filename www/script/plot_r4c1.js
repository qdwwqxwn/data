   var year = ['2005-01', '2006-01', '2007-01', '2008-01', '2009-01', '2010-01',
               '2011-01', '2012-01', '2013-01', '2014-01', '2015-01', '2016-01'];

   var traces = [
    { x: year, 
      y: [0.46,0.61,0.62,0.60,0.43,0.41,0.22,0.26,0.24,0.42,0.11,0.12], 
      name: 'Beijing',
      fill: 'tozeroy', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.19,0.42,0.54,0.37,0.23,0.20,0.17,0.07,0.12,0.10,0.10,0.07], 
      name: 'Guangzhou',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.31,0.36,0.48,0.71,0.28,0.37,0.24,0.56,0.22,0.33,0.23,0.11], 
      name: 'Hefei',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.84,0.99,1.13,1.47,0.62,0.69,0.97,1.07,1.02,0.69,0.33,0.48], 
      name: 'Jinan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.34,0.42,0.58,0.84,0.24,0.27,0.30,0.42,0.36,0.21,0.24,0.18], 
      name: 'Nanjing',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.45,0.43,0.68,0.65,0.27,0.29,0.31,0.34,0.20,0.20,0.21,0.15], 
      name: 'Shanghai',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [1.96,1.57,1.49,1.60,1.10,1.11,0.95,1.15,0.98,0.75,0.36,0.51], 
      name: 'Shijiazhuang',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.69,0.63,0.68,0.87,0.54,0.63,0.39,0.65,0.36,0.42,0.29,0.34], 
      name: 'Taiyuan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.44,0.65,0.93,0.71,0.44,0.57,0.31,0.62,0.51,0.51,0.18,0.17], 
      name: 'Tangshan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.66,0.81,0.95,0.82,0.61,0.58,0.33,0.65,0.52,0.49,0.27,0.15], 
      name: 'Tianjin',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.47,0.30,0.51,0.58,0.19,0.26,0.23,0.57,0.34,0.30,0.23,0.14], 
      name: 'Wuhan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.71,0.57,0.53,0.55,0.27,0.31,0.20,0.46,0.26,0.34,0.06,0.08], 
      name: 'Xian',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [1.09,1.01,1.11,1.76,0.63,0.58,0.74,1.28,0.80,0.85,0.34,0.34], 
      name: 'Zhengzhou',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.97,1.09,1.13,1.44,0.68,0.68,0.78,1.16,1.04,0.70,0.41,0.37], 
      name: 'Zibo',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
   ]; 

function stackedArea(traces) {
	for(var i=1; i<traces.length; i++) {
		for(var j=0; j<(Math.min(traces[i]['y'].length, traces[i-1]['y'].length)); j++) {
			traces[i]['y'][j] += traces[i-1]['y'][j];
		}
	}
	return traces;
}

var layout = { title: 'SO2 Concentration by City', 
               xaxis: {type: 'Date', title: 'Year'},
               yaxis: {title: 'SO2'},
               showlegend: true
             }; 

Plotly.newPlot('r4c1', stackedArea(traces), layout, 
      {showLink: false, displaylogo: false, modeBarButtonsToRemove: ['sendDataToCloud','hoverCompareCartesian']});

