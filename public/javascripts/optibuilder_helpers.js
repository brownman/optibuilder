/*************************************************************************
* @method: 	Function to create a data store
* @author: Ronaldo Possan
* @since: 2010/08/06
* @param: url(String) *Url for request to server for get json store
* @param: fields(Array) *Fields from JSON object
* @param: mapping(Array) *Array of JSON data and fields for the store
* @extends: Ext.data.Store
* @return: Store
*************************************************************************/
function createStore(url, fields, mapping){
	var ret =
	new Ext.data.Store({
		autoload: false,
		fields: fields,
		proxy:  new Ext.data.HttpProxy({
			method: 'GET',
			url: url
		}),
		reader: new Ext.data.JsonReader({
			fields: mapping,
			id: 'id',
			root: 'root',
			totalProperty: 'totalCount'
		})
	});
	return ret;
}

/*************************************************************************
Function to confirm logout
*************************************************************************/
function confirmLogout(){
	Ext.Msg.confirm('Logout',
					'Do you want to logout?',
					function(btn) {
						if (btn == 'yes'){
							location.assign('login/logout');
							treeState.clearState();
						}
					}
	);
}

/*************************************************************************
Function to create a generic Command Bar
*************************************************************************/
function createCmdBar(btns){
	var ret = new Ext.Toolbar({
			items: btns,
			width: 200,
			autoWidth: false
			})
	return ret;
}

/*************************************************************************
Function to create a generic Pagination Bar
*************************************************************************/
function createPBar(store, name){
	ret = "";
	ret = new Ext.PagingToolbar({
						  pageSize: 10,
						  store: store,
						  displayInfo: true,
						  displayMsg: 'Listing ' + name + ' {0} - {1} of {2}',
						  emptyMsg: "No registers to show"
						  /*items: [new Ext.Button ({ text: 'Search',
						  							handler: function(){alert('oi');}
						  							}
						  						)]*/
						})
	return ret;
}

/*************************************************************************
* @method: 	Function to create a generic data grid
* @author: Ronaldo Possan
* @since: 2010/08/06
* @param: store(Ext.data.Store Object) *Data store to populates grid
* @param: title(String) *Title for grid
* @param: tbar(Array of Objects) *Array of objects to create top bar
* @param: bbar(Array of Objects) *Array of objects to create bottom bar
* @param: cols(Array) *Array representing columns of the grid
* @extends: Ext.grid.GridPanel
* @return: GridPanel
*************************************************************************/
function createGrid(store, title, tbar, bbar, cols){
	var ret = "";
	ret =
	new Ext.grid.GridPanel({
			autoHeight: true,
			autoWidth: true,
			title: title,
			store: store,
      		//trackMouseOver: false,
      		//disableSelection: true,
      		//enableColumnMove: false,
      		loadMask: true,
      		columns: cols,
      		bbar: bbar,
      		tbar: tbar,
			stripeRows: true,
      		listeners: 	{
      						cellclick: function(grid, linha, coluna){
								/*if(cols[coluna].id == 'delete'){
									id = store.getAt(linha).get('id');
									alert('deletar');
									//excluirRegistro(id);
								}
								if(cols[coluna].id == 'edit'){
									id = store.getAt(linha).get('id');
									alert('editar');
									//excluirRegistro(id);
								}*/
      						}
						}
		});
	return ret;
}

/*************************************************************************
* @method: Generic function to add a Tab in main tab Panel
* @author: Ronaldo Possan
* @since: 2010/08/06
* @param: tabId(String) *Id for tab
* @param: title(String) *Title to display on tab
* @param: subTitle(String) *Subtab title
* @param: url(String) *Url for page to show on tab content
* @param: icon[optional](String / CSS Class) *Css class where contain icon for tab
* @extends: Ext.grid.GridPanel
* @return: void
*************************************************************************/
function addTab(tabId, title, subtitle, url, icon){
	if ( icon === undefined ) {
	        icon = "tabIndexIcon";
    }
	var tabPanel = Ext.getCmp('my-tabs');
	var tab = tabPanel.getItem(tabId);
	if(tab){
		tab.show();
	}else{
        tab = tabPanel.add({
                   title: title,
                   id: tabId,
                   iconCls: icon,
                   closable:true,
                   autoScroll:true,
                   bodyStyle:{overflow:'auto'},
                   xtype: 'tabpanel',
                   activeTab: 0,
                   items: [{id: 'sub_'+tabId,
                   			title: subtitle,
                   			iconCls: 'tabIndexIcon',
                   			autoLoad: {url: url, callback: loadingFailed, scope: this, scripts: true},
                   			closable: false,
                   			autoScroll:true
                   			}]
                   });
         tab.show();
        // tabPanel.setActiveTab(tab);
	}
};


/*************************************************************************
* @method: Generic function to add a sub-tab into tab to tab panel
* @author: Ronaldo Possan
* @since: 2010/08/06
* @param: tabId(String) *Id for tab
* @param: subTabId(String) *Id for new subtab generated on tab
* @param: title(String) *Title to display on subtab
* @param: url(String) *Url for page to show on tab content
* @param: icon[optional](String / CSS Class) *Css class where contain icon for tab
* @extends: Ext.grid.GridPanel
* @return: void
*************************************************************************/
function addSubTab(tabId, subTabId, title, url, icon){
	if ( icon === undefined ){ icon = "tabs"; }
    var tabPanel = Ext.getCmp('my-tabs');
    var tab = tabPanel.getItem(tabId);
    var subtab = tab.getItem(subTabId);

	if(subtab){
		subtab.show();
	}else{
	 	subtab =
			tab.add({
				id: subTabId,
				iconCls: icon,
	            title: title,
	            autoLoad: {url: url, callback: loadingFailed, scope: this, scripts: true},
	            closable: true,
	            autoScroll:true
			});
		subtab.show();
	}
}

/*************************************************************************
Generic function to add a sub-tab and under tabs to a sub tab and panel tab
*************************************************************************/
function addUnderTab(tabId, subTabId, underTabId, title, subTitle, url) {
  var tabPanel = Ext.getCmp('my-tabs');
  var tab = tabPanel.getItem(tabId);
  var subtab = tab.getItem(subTabId);

  if(subtab) {
    subtab.show();
  }
  else {
    subtab = tab.add({
      title: title,
      id: subTabId,
      closable:true,
      autoScroll:true,
      bodyStyle:{overflow:'auto'},
      xtype: 'tabpanel',
      activeTab: 0,
      tabPosition: 'bottom',
      items:[{
        autoLoad: {url:  url, callback: loadingFailed, scope: this, scripts: true},
        title: subTitle,
        id: underTabId,
        closable: false,
        autoScroll:true
      },
      {
        autoLoad: {url:  url, callback: loadingFailed, scope: this, scripts: true},
        title: subTitle,
        id: underTabId+'01',
        closable: false,
        autoScroll:true
      },
      {
        autoLoad: {url:  url, callback: loadingFailed, scope: this, scripts: true},
        title: subTitle,
        id: underTabId+'02',
        closable: false,
        autoScroll:true
      }]
    });
    subtab.show();
    tab.setActiveTab(subtab);
  }
}

/*************************************************************************
* @method: Generic function to update a sub-tab into tab to tab panel if exists
* @author: Ronaldo Possan
* @since: 2010/08/06
* @param: tabId(String) *Id of tab
* @param: subTabId(String) *Id of subtab
* @param: title(String) *New title for subtab updated
* @param: url(String) *Url for page to show on tab content
* @param: icon[optional](String / CSS Class) *Css class where contain icon for tab
* @extends: Ext.grid.GridPanel
* @return: void
*************************************************************************/
function updateSubTab(tabId, subTabId, title, url) {
    var tabPanel = Ext.getCmp('my-tabs');
    var tab = tabPanel.getItem(tabId);
    var subtab = tab.getItem(subTabId);

    if(subtab){
      subtab.getUpdater().update({url: url, callback: loadingFailed});
      subtab.setTitle(title);
      subtab.show();
    }
}

/*************************************************************************
Generic function to close a tab including yours dependentes in cascade
*************************************************************************/
function closeTab(tabId) {
  var tabPanel = Ext.getCmp('my-tabs');
  var tab = tabPanel.getItem(tabId);
    if(tab){ tabPanel.remove(tab); }
}

/*************************************************************************
Generic function to close a sub-tab into tab to tab panel
*************************************************************************/
function closeSubTab(tabId, subTabId) {
  var tabPanel = Ext.getCmp('my-tabs');
  var tab = tabPanel.getItem(tabId);
  var subtab = tab.getItem(subTabId);
  if(subtab){ tab.remove(subtab); }
}

/*************************************************************************
 * Try to load the tab again if the loading fails
*************************************************************************/

function loadingFailedMessage(el, success, response, options){
   if (!success){ Ext.Msg.alert('Erro','Ocorreu um erro.'); }
}

function loadingFailed(el, success, response, options) {
    if (!success){ el.getUpdater().update({url: options.url, callback: loadingFailedMessage, scripts:true}); }
}

/*************************************************************************
Function to print  a sub-tab
* @author:Mariana Souza
*************************************************************************/
function printSubTab(mylink,windowname){
	if (! window.focus)return true;
		var href;
	if (typeof(mylink) == 'string')
	   href=mylink;
	else
	   href=mylink.href;
	   window.open(href,  windowname,'location=0,menubar=1,toolbar=1,scrollbars=1');
	return false;
}
/*************************************************************************
* @method: Generic function to add a Tab in main tab Panel Test
* @author: Mariana Souza
* @since: 2011/03/02
* @param: tabId(String) *Id for tab
* @param: title(String) *Title to display on tab
* @param: subTitle(String) *Subtab title
* @param: url(String) *Url for page to show on tab content
* @param: icon[optional](String / CSS Class) *Css class where contain icon for tab
* @extends: Ext.grid.GridPanel
* @return: void
*************************************************************************/
function addTestTab(tabId, title, url, icon){
	if ( icon === undefined ) {
	        icon = "tabIndexIcon";
    }
	var tabPanel = Ext.getCmp('test_tab_panel');
	var tab = tabPanel.getItem(tabId);
	if(tab){
		tab.show();
	}else{
        tab = tabPanel.add({
                   title: title,
                   id: tabId,
                   iconCls: icon,
                   width:400,
                   autoHeight:true,
                   bodyCfg: {cls: 'tabContent'},
                   closable:true,
                   autoScroll:true,
                   bodyStyle:{overflow:'auto'},
                   activeTab: 0,
				   autoLoad: {url: url, callback: loadingFailed, scope: this, scripts: true},
                   });
         tab.show();
        // tabPanel.setActiveTab(tab);
	}
};

/*************************************************************************
* @method: Generic function to update a sub-tab into tab to test tab panel if exists
* @author: Mariana Souza
* @since: 2011/03/02
* @param: tabId(String) *Id of tab
* @param: subTabId(String) *Id of subtab
* @param: title(String) *New title for subtab updated
* @param: url(String) *Url for page to show on tab content
* @param: icon[optional](String / CSS Class) *Css class where contain icon for tab
* @extends: Ext.grid.GridPanel
* @return: void
*************************************************************************/
function updateTestTab(tabId) {
    var tabPanel = Ext.getCmp('test_tab_panel');
    var tab = tabPanel.getItem(tabId);


    if(tab){
      tab.getUpdater().update({callback: loadingFailed});
      tab.show();
    }
}

/*************************************************************************
Generic function to close a tab including yours dependentes in cascade for Tests
* @author: Mariana Souza
* @since: 2011/03/02
*************************************************************************/
function closeTestTab(tabId) {
  var tabPanel = Ext.getCmp('test_tab_panel');
  var tab = tabPanel.getItem(tabId);
    if(tab){ tabPanel.remove(tab); }
}




























