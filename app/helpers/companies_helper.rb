module CompaniesHelper
  def include_buttons_Companies
    ret = "
        function createCompaniesBtns(){
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
                                        tooltip: 'Add new Company',
                                        handler: function(){ newCompany();}
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
                                                //store_Companies.baseParams.findby = filtroColuna;
                                                store_Companies.baseParams.query = args_txt;
                                                store_Companies.load({params: {start:0 , limit:10}});
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
