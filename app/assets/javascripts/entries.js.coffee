jQuery ->
  $('#saisies').dataTable
    sPaginationType: "bootstrap"
    # bJQueryUI: true
    bProcessing: true
    oLanguage: {
      sUrl: "//cdn.datatables.net/plug-ins/1.10.15/i18n/French.json"
    }
    # bServerSide: true
    # sAjaxSource: $('#campaigns').data('source')
