module SubrackNamesHelper
  def include_buttons_Subrack_names
    ret = "
        function createSubrack_namesBtns(){
            var txt_search = new Ext.form.TextField({name: 'search'});
            var retArray =
            [
            new Ext.Button ({ text: 'Add new',
                              id: 'btnNew',
                              iconCls: 'addNewIcon',
                              tooltip: 'Add new project',
                              handler: function(){ newSubrack_name();}
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
                                    store_Subrack_names.baseParams.query = args_txt;
                                      store_Subrack_names.load({params: {start:0 , limit:10}});
                              }
                             })
                ]
              return retArray;
          }
    "
    return ret
  end
end
