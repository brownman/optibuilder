module SpansHelper
  def include_buttons_Spans
    ret = "
        function createSpansBtns(){
            var txt_search = new Ext.form.TextField({name: 'search'});
            var retArray =
            [
                      new Ext.Button ({ text: 'Add new',
                                        id: 'btnNew',
                                        iconCls: 'addNewIcon',
                                        tooltip: 'Add new span',
                                        handler: function(){ newSpan();}
                                     }),
                          new Ext.Spacer({width: 20}),
                          new Ext.form.Label({text: 'Search: ', id: 'lblSearch' }),
                          //cbPesquisa,
                          txt_search,
                          new Ext.Button ({
                                            text: 'Go',
                                            iconCls: 'searchButton',
                                            id: 'btnSearch',
                                            handler: function(){
                                              args_txt = txt_search.getValue();
                                                 store_Spans.baseParams.query = args_txt;
                                                store_Spans.load({params: {start:0 , limit:10}});
                                       }
                                       })
                    ]
              return retArray;
          }
    "
    return ret
  end
end
