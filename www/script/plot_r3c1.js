   var year = ['2005-01', '2006-01', '2007-01', '2008-01', '2009-01', '2010-01',
               '2011-01', '2012-01', '2013-01', '2014-01', '2015-01', '2016-01'];

   var traces = [
    { x: year, 
      y: [1.00,1.32,1.58,1.23,1.42,1.46,1.29,1.31,1.61,1.30,1.17,1.07], 
      name: 'Beijing',
      fill: 'tozeroy', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.87,0.93,1.01,0.94,0.80,0.91,0.87,0.89,0.74,0.71,0.76,0.55], 
      name: 'Guangzhou',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.77,0.75,0.93,1.02,0.70,0.88,1.00,1.45,1.18,1.09,0.93,0.68], 
      name: 'Hefei',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [1.04,1.20,1.60,1.57,1.22,1.88,2.10,2.15,1.62,1.77,1.49,1.21], 
      name: 'Jinan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [1.08,1.03,1.21,1.54,1.04,1.37,1.37,1.38,1.37,1.34,1.25,0.96], 
      name: 'Nanjing',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [1.13,1.37,1.25,1.40,1.43,1.46,1.38,1.40,1.31,1.24,1.53,1.05], 
      name: 'Shanghai',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [1.19,1.23,1.71,1.59,1.48,2.03,1.94,2.06,2.14,1.76,1.22,1.23], 
      name: 'Shijiazhuang',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.60,0.65,0.79,0.91,0.70,0.55,0.84,1.10,1.01,0.96,0.75,0.58], 
      name: 'Taiyuan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.67,0.96,1.33,1.05,1.11,1.39,1.38,1.28,1.47,1.42,1.14,1.08], 
      name: 'Tangshan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.93,1.31,1.70,1.28,1.40,1.59,1.51,1.64,1.69,1.57,1.38,1.21], 
      name: 'Tianjin',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.64,0.63,0.72,0.82,0.66,0.86,1.11,1.33,0.94,1.02,0.83,0.60], 
      name: 'Wuhan',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.56,0.72,0.73,0.81,0.79,0.97,1.02,1.16,1.04,1.08,0.86,0.52], 
      name: 'Xian',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [1.31,1.08,1.40,1.86,1.34,1.79,1.90,2.09,2.12,1.79,1.42,0.84], 
      name: 'Zhengzhou',
      fill: 'tonexty', 
      type: 'scatter'
    }, 
    { x: year, 
      y: [0.98,1.24,1.50,1.45,1.17,1.66,1.87,2.17,1.52,1.70,1.58,1.27], 
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

var layout = { title: 'NO2 Concentration by City', 
               xaxis: {type: 'Date', title: 'Year'},
               yaxis: {title: 'NO2'},
               showlegend: true
             }; 

Plotly.newPlot('r3c1', stackedArea(traces), layout, 
      {showLink: false, displaylogo: false, modeBarButtonsToRemove: ['sendDataToCloud','hoverCompareCartesian']});

