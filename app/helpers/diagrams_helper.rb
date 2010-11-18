module DiagramsHelper
  def include_buttons_Diagrams
    ret = "
        function createDiagramsBtns(){
            var txt_search = new Ext.form.TextField({name: 'search'});
            var retArray =
            [
            new Ext.Button ({ text: 'Add new',
                              id: 'btnNew',
                              iconCls: 'addNewIcon',
                              tooltip: 'Add new project',
                              handler: function(){ newDiagram();}
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
                                    store_Diagrams.baseParams.query = args_txt;
                                    store_Diagrams.load({params: {start:0 , limit:10}});
                                  }
                               })
            ]
            return retArray;
        }"
    return ret
  end
end
