module TestPmdsHelper
  def include_buttons_TestPmds
      ret = "
        function createTestPmdsBtns(){
            var txt_search = new Ext.form.TextField({name: 'search'});
            var retArray =
                [
                new Ext.Button ({ text: 'Input Tests',
                                  id: 'btnNew',
                                  iconCls: 'addNewIcon',
                                  tooltip: 'Add new test_pmds',
                                  handler: function(){ newTestPmd();}
                               }),
                new Ext.Spacer({width: 20}),
                new Ext.form.Label({text: 'Search: ', id: 'lblSearch' }),
                //cbPesquisa,
                txt_search,
                new Ext.Button ({ text: 'Go',
                                  iconCls: 'searchButton',
                                  id: 'btnSearch',
                                  handler: function(){
                                    args_txt = txt_search.getValue();
                                    store_TestChromaticDisps.baseParams.query = args_txt;
                                    store_TestChromaticDisps.load({params: {start:0 , limit:10}});
                                  }
                               })
                ]
                return retArray;
        }"
    return ret
  end
end
