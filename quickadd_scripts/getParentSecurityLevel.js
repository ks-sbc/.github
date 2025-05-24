module.exports = async (params) => {
    const { quickAddApi, app } = params;
    let parentSecLevel = ""; 
    const activeFile = app.workspace.getActiveFile();
    if (activeFile) {
        const fileCache = app.metadataCache.getFileCache(activeFile);
        if (fileCache && fileCache.frontmatter && fileCache.frontmatter.security) {
            parentSecLevel = fileCache.frontmatter.security;
        }
    }
    // This makes 'parentSecLevel' available to subsequent macro actions
    // AND as a variable {{VALUE:parentSecLevel}} in things like folder paths.
    // For Templater, it's usually accessed via `params.variables.parentSecLevel` if QuickAdd runs it as a script,
    // or `tp.variables["parentSecLevel"]` if Templater plugin itself sources these.
    quickAddApi.setVariable("parentSecLevel", parentSecLevel); 
};
