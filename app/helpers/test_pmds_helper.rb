module TestPmdsHelper
  def include_buttons_TestPmds
      ret = "
        function createTestPmdsBtns(){
            var txt_search = new Ext.form.TextField({name: 'search', emptyText: 'Insert a project or site name',width: '180'});
            var retArray =
                [

                new Ext.Spacer({width: 10}),
                new Ext.form.Label({text: 'Search: ', id: 'lblSearch' }),
                //cbPesquisa,
                txt_search,
                new Ext.Button ({ text: 'Go',
                                  iconCls: 'searchButton',
                                  id: 'btnSearch',
                                  handler: function(){
                                    args_txt = txt_search.getValue();
                                    store_TestPmds.baseParams.query = args_txt;
                                    store_TestPmds.load({params: {start:0 , limit:10}});
                                  }
                               })
                ]
                return retArray;
        }"
    return ret
  end

   def include_buttons_Pmds
      ret = "
        function createPmdsBtns(){
            var txt_search = new Ext.form.TextField({name: 'search', width: '180'});
            var retArray =
                [
                 new Ext.Button ({ text: 'Add new',
                                        id: 'btnNew',
                                        iconCls: 'addNewIcon',
                                        tooltip: 'Add new Test Pmd',
                                        handler: function(){ newTestPmd();}
                                     }),
                new Ext.Spacer({width: 10}),
                new Ext.form.Label({text: 'Search: ', id: 'lblSearch' }),
                //cbPesquisa,
                txt_search,
                new Ext.Button ({ text: 'Go',
                                  iconCls: 'searchButton',
                                  id: 'btnSearch',
                                  handler: function(){
                                    args_txt = txt_search.getValue();
                                    store_Pmds.baseParams.query = args_txt;
                                    store_Pmds.load({params: {start:0 , limit:10}});
                                  }
                               })
                ]
                return retArray;
        }"
    return ret
  end



def include_preview_results

   ret = "function PreviewResults(){

      var dlgPopup,nav;
       nav = new Ext.Panel({
            title: 'Test Pmd for Fiber',
            width: 350,
            html:'<body><fieldset><legend>Test_Pmd</legend><table><tr><th>Fiber:</th><td><%= @test_pmd.fiber_id %></td></tr></table></fieldset></body>',
            collapsible: true,
        });

  var dlgPopup = new Ext.Window({
          modal:true,
          layout:'fit',
          width:500,
          height:400,
          closable:false,
          resizable:false,
          plain:true,
          items:[nav],
          buttons:[{
            text:'close',
            handler:function() {
              dlgPopup.close();
            }
          }]
        });
   dlgPopup.show();
}"
    return ret

end


end













