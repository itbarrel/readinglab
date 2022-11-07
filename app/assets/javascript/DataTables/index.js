var DataTable = require('datatables.net');
require( 'datatables.net-buttons' );
require( 'datatables.net-responsive' );
 
$.fn.dataTable = DataTable;
$.fn.dataTableSettings = DataTable.settings;
$.fn.dataTableExt = DataTable.ext;
DataTable.$ = $;
 
$.fn.DataTable = function ( opts ) {
    return $(this).dataTable( opts );
};