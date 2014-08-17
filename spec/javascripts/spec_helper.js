//= require application

//= require sinon
//= require chai-changes
//= require js-factories
//= require chai-backbone
//= require chai-jquery

//= require angular-mocks

mocha.ui('bdd');

mocha.globals(['angular', '$']);

mocha.ignoreLeaks();

mocha.timeout(5);

chai.config.includeStack = true;

function once(fn) {
    var returnValue, called = false;
    return function () {
        if (!called) {
            called = true;
            returnValue = fn.apply(this, arguments);
        }
        return returnValue;
    };
}

// be guard || be rake konacha:serve
