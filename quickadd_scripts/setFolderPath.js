module.exports = async (params) => {
    const { quickAddApi, variables } = params;
    const securityLevel = variables.selectedSecurityLevel;
    let folderPath = "";
    if (securityLevel === "Public") {
        folderPath = "content/L0_public";
    } else if (securityLevel === "Candidate") {
        folderPath = "content/L1_candidate";
    } else if (securityLevel === "Cadre") {
        folderPath = "content/L2_cadre";
    } else {
        // Default or error
        new Notice("Invalid security level selected. Defaulting to root.");
        folderPath = ""; // Or a default path
    }
    quickAddApi.setVariable("targetFolderPath", folderPath);
};
