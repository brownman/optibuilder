module FibersHelper
  def include_buttons_Fibers
    ret = "
        function createFibersBtns(){
            var txt_search = new Ext.form.TextField({name: 'search'});
            /*var cb_search =
                      new Ext.form.ComboBox({
                            store: ['name'],
                            emptyText: 'Select...',
                            value: 'nome',
                            typeAhead: true,
                            forceSelection: true,
                            triggerAction: 'all',
                            selectOnFocus:true,
                            editable: false
                      });*/
            var retArray =
            [
                      new Ext.Button ({ text: 'Add new',
                                        id: 'btnNew',
                                        iconCls: 'addNewIcon',
                                        tooltip: 'Add new user',
                                        handler: function(){ newUser();}
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
                                              //filtroColuna = cbPesquisa.getValue();
                                              args_txt = txt_search.getValue();
                                              /*if(filtroColuna == '' || filtroColuna == null){
                                                Ext.Msg.alert('Erro', 'Selecione uma coluna para filtrar!');
                                              }else{*/
                                                //store_Fibers.baseParams.findby = filtroColuna;
                                                store_Fibers.baseParams.query = args_txt;
                                                store_Fibers.load({params: {start:0 , limit:10}});
                                              //}
                                        }
                                       })
                    ]
              return retArray;
          }
    "
    return ret
  end
end
