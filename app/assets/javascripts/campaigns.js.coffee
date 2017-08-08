jQuery ->
  $('#campaigns').dataTable
    sPaginationType: "full_numbers"
    bProcessing: true
    oLanguage: {
      sUrl: "//cdn.datatables.net/plug-ins/1.10.15/i18n/French.json"
    }
    aoColumns: [{ "sType": "string", "aTargets": [ 0 ] }, null, null, null, null, null, null]
#     sDom: 'Bfrtip'
#     aButtons: [
#       {
#         extend: 'copyHtml5',
#         text: "copy to clipboard"
#       },
#       {
#         extend: 'excelHtml5',
#         text: 'Save as excel sheet'
#       },
#       'csvHtml5',
#       'pdfHtml5'
#     ]
    # bServerSide: true
    # sAjaxSource: $('#campaigns').data('source')

jQuery ->
  $('#dash').dataTable
    sPaginationType: "full_numbers"
    # bJQueryUI: true
    bProcessing: true
    oLanguage: {
      sUrl: "//cdn.datatables.net/plug-ins/1.10.15/i18n/French.json"
    }
    # bServerSide: true
    # sAjaxSource: $('#campaigns').data('source')

# // $(document).ready(function() {
# //     $('#campaigns').DataTable( {
# //       dom: 'Bfrtip',
# //       buttons: [
# //         {
# //           extend: 'copyHtml5',
# //           text: "copy to clipboard"
# //         },
# //         {
# //           extend: 'excelHtml5',
# //           text: 'Save as excel sheet'
# //         },
# //         'csvHtml5',
# //         'pdfHtml5'
# //       ]
# //     });
# // });
