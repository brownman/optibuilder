
Ext.onReady(function(){

	//Override to set default formt for date fields
	//Ext.override(Ext.form.DateField, {format: 'd/m/Y'});

	// turn on validation errors beside the field globally
	Ext.form.Field.prototype.msgTarget = 'side';

	// Required if showing validation messages
	Ext.QuickTips.init();

	// Save panels state
	Ext.state.Manager.setProvider(new Ext.state.CookieProvider());


	/*************************************************************************
	* @method: 	Override to create an attribute and to create tooltip
	* 			for form fields
	* @author: Ronaldo Possan
	* @since: 2010/11/10
	* @property: helpMsg 
	* @param: String[HTML] *Free html escape
	* @extends: Ext.form.Field
	* @return: QuickTips
	*************************************************************************/
	Ext.override(
		Ext.form.Field, 
	    {
			afterRender : Ext.form.Field.prototype.afterRender.createSequence(
				function(){
		            var qt = this.helpMsg;
		            if (qt){   
						Ext.QuickTips.register({
			                target:  this,
			                title: '',
			                text: '<div class="extHelpMsg">'+qt+'</div>',
			                enabled: true,
			                showDelay: 0
		                });
		            }
	        	}
			)
	    }
	);

  var otabs = new Ext.TabPanel({
    region:'center',
    id: 'my-tabs',
    resizeTabs:true,
    minTabWidth: 115,
    tabWidth:135,
    defaults: {autoScroll:true},
    enableTabScroll:true,
    deferredRender:false,
    activeTab:0,
	margins:{top:0, right:10, bottom:5, left:0},
    items:[
      {
        contentEl:'main',
        iconCls: 'tabWelcomeIcon',
        title: 'Welcome',
        closable:true,
        autoScroll:true
      }
    ]
  });


  // Build layout
	viewport = new Ext.Viewport({
		layout:'border',
		items:[
			new Ext.BoxComponent({
				region:'north',
				el: 'north',
				height:5
			}),
			{
				region:'west',
				id:'west-panel',
				el:'west',
				split: true,
				width: 245,
				minSize: 245,
				maxSize: 400,
				collapsible: true,
				margins:'0 0 0 5',
				layout:'accordion',
				layoutConfig:{animate:true, sequence:true},
				items: [
					{
						title: 'Setup',
						contentEl: 'setup',
						border: false
					}, {
						title: 'Tests',
						contentEl: 'tests',
						border: false
					}, {
						title: 'Reports',
						contentEl: 'reports',
						border: false
					}
				]
			}, otabs
		]
	});

});

