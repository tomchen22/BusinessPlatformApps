"use strict";
function configure(aurelia) {
    aurelia.use.standardConfiguration();
    aurelia.start().then(function () { return aurelia.setRoot(); });
}
exports.configure = configure;
