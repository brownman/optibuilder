module SitesHelper
  def include_buttons_Sites
    ret = "
        function createSitesBtns(){
            var txt_search = new Ext.form.TextField({name: 'search'});
            var retArray =
            [
                      new Ext.Button ({ text: 'Add new',
                                        id: 'btnNew',
                                        iconCls: 'addNewIcon',
                                        tooltip: 'Add new Site',
                                        handler: function(){ newSite();}
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
                                              store_Sites.baseParams.query = args_txt;
                                              store_Sites.load({params: {start:0 , limit:10}});
                                            }
                                         })
                    ]
              return retArray;
          }
    "
    return ret
  end
end
