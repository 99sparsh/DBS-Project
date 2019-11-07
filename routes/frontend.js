exports.airlineHome = async (req, res) => {
    res.render("airlinehome");
};
exports.index = async (req, res) => {
    res.render("index");
};
exports.addbooking = async (req, res) => {
    res.render("addbooking");
};
exports.addcabincrew = async (req, res) => {
    res.render("addcabincrew");
};
exports.addgroundstaff = async(req,res) => {
    res.render("addgroundstaff");
}
exports.addPilot = async(req,res) => {
    res.render("addpilot");
}
