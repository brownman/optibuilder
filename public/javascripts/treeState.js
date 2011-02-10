    /*
     * A state model for the extjs TreePanel. Use the init method
     * to initialize the object and don't forget to attach the
     * the expand and collaps event handlers on your TreePanel.
     *
     * 10. July 2007
     * gnaegi@frentix.com
     */
    function TreePanelState(mytree) {
            this.mytree = mytree;
    }

    /*
     * The init method must be called after object creation
     * to initialize the cookie provider
     */
    TreePanelState.prototype.init = function() {
            this.cp = new Ext.state.CookieProvider();
            this.state = this.cp.get('TreePanelState_' + this.mytree.id, new Array() );
    }

    /*
     * Internal helper to save state in cookie.
     */
    TreePanelState.prototype.saveState = function(newState) {
            this.state = newState;
            this.cp.set("TreePanelState_" + this.mytree.id, this.state);
    }

    /*
     * Method should be called when expanding a node. 
     * The method removes all contained pathes from the
     * state model, they are implicitly opened by this
     * new path.
     */
    TreePanelState.prototype.onExpand = function(node) {
            var currentPath = node.getPath();
            var newState = new Array();
            for (var i = 0; i < this.state.length; ++i) {
                    var path = this.state[i];
                    if (currentPath.indexOf(path) == -1) {
                            // this path does not already exist
                            newState.push(path);			
                    }
                    // ignore contained path, implicitly opened by new path
            }
            // now ad the new path
            newState.push(currentPath);
            this.saveState(newState);
    }

    /*
     * Method should be called when collapsing a node. 
     * The method removes all contained pathes from the
     * state model.
     */
    TreePanelState.prototype.onCollapse = function(node){
        var closedPath = closedPath = node.getPath();
        var parentNode = node.parentNode;
        var newState = new Array();
            for (var i = 0; i < this.state.length; ++i) {
                    var path = this.state[i];
                    if (path.indexOf(closedPath) == -1) {
                            // this path is not a subpath of the closed path
                            newState.push(path);		
                    } else {
                        // insert the path to parent node of the closed node
                        newState.push(parentNode.getPath());
                    }
            }
            if (newState.length == 0) {
                    var parentNode = node.parentNode;
                    newState.push((parentNode == null ? this.mytree.pathSeparator : parentNode.getPath()));
            }
            this.saveState(newState);
    }

    /*
     * Restore the last state from the cookies or use 
     * the default path if no state has been found.
     */
    TreePanelState.prototype.restoreState = function(defaultPath) {	
            if (this.state.length == 0) {
                    var newState = new Array(defaultPath);
                    this.saveState(newState);		
                    this.mytree.expandPath(defaultPath);
                    return;
            }
            for (var i = 0; i < this.state.length; ++i) {
                    // activate all path strings from the state
                    try {
                        var path = this.state[i];
                        this.mytree.expandPath(path);  		
                    } catch(e) {
                            // ignore invalid path, seems to be removed in the datamodel
                            // add debugging here if your tree does not expand as expected
                    }
            }	
    }

    /*
     * Clear the tree state cookie
     */
    TreePanelState.prototype.clearState = function() {
        this.cp.clear("TreePanelState_" + this.mytree.id);
    }