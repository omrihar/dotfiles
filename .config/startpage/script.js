const NAME = "Omri";
const WELCOME_MESSAGE_TEMPLATE = ["night", "morning", "afternoon", "evening"];

// All shortcuts are in a `SHORTCUT_STARTER+shortcutKey` format.
// So, for example, pressing `tab+q` would redirect you to https://google.com/?q=q
const SHORTCUT_STARTER = 'control';

// How much time (in milliseconds) you have to press shortcutKey after pressing SHORTCUT_STARTER.
// Also change --SHORTCUT_TIMEOUT in styles.css if you change this option.
const SHORTCUT_TIMEOUT = 1500;

// The groups of links are generated from this object. Edit it to edit the page's contents.
// shortcutKey must hold an all-lowercase single button. Theoretically should work with values like `esc` and `f1`,
// but intended to be used with just regular latin letters.
const MASTER_MAP = [
    {
        "groupName": "Tools",
        "items":[
            {"name": "Keep", "shortcutKey": "k", "url": "http://keep.google.com"},
            {"name": "Calendar", "shortcutKey": "c", "url": "https://calendar.google.com"},
            {"name": "Maps", "shortcutKey": "m", "url": "https://maps.google.com"},
            {"name": "GitKraken", "url": "gitkraken://test"},
            {"name": "Mongo Compass", "shortcutKey": "a", "url": "mc://test"},
        ]
    },
    {
        "groupName": "Work",
        "items":[
            {"name": "Github", "shortcutKey": "g", "url": "https://github.com/schmiedeone"},
            {"name": "JIRA", "shortcutKey": "j", "url": "https://schmiedeone.atlassian.net/secure/Dashboard.jspa"},
            {"name": "Confluence CNHI", "shortcutKey": "d", "url": "https://schmiedeone.atlassian.net/wiki/spaces/C/pages/edit/1041596417?draftId=1041268744&draftShareId=b2f590b7-d06f-4020-a79d-39dd5a9f24fc&"},
            {"name": "Click-dummy", "shortcutKey": "b", "url": "https://marvelapp.com/b1gd5c4/screen/54859537"},
            {"name": "Team Drive", "url": "https://idp.mycloud.com/idp/SSO.saml2?SAMLRequest=lVPLbqMwFN3PV1jeh5cIJVagyqSqplJHiQKdRTeVay6tJbAZX5Omfz8GEolFp2pXyPY9556HWF%2Bf2oYcwaDUKqOhF1ACSuhKqpeMPpS3i5Re5z%2FWyNumY5vevqoD%2FO0BLdkggrEOttUK%2BxZMAeYoBTwc7jP6am2HzPd5J723KnrRntDtcPLdCt84vD9QPrnNsn6n5MbdSMXtqOICllXnte%2Bi0X01wt3ZL4qdNyAjSm61ETBKyqg1PVByd5PRp7he8qRK65gnKQ9CSKJ4%2BRzEIr5KllGVrNwY7jmiPEJGa97gAETs4U6h5cpmNArC1SKIF0FaBilbhiwOvatV%2BkjJ3mirhW5%2BSjUl1BvFNEeJTPEWkFnBis3vexZ5AXuehpD9Ksv9Yr8rSkr%2BXJKOhqRd9grZmO3nVN15L83PTYyCzdcJ%2BKUsmu%2BM%2B2w6ea5r7c8ZJ%2F6oY%2BeWoRoDdhVbOFmy1W3HjcTBAZy4sHMP0fdMsDnztnEKD1DP6L5s6NMxwcRA7a6Hzt%2B0qYYOQThnpeEKO23sFMGHevLp7X%2BB5Jf05n9G%2Fg8%3D&RelayState=d34e6a406efb0f57c21de7705b3bdce9d3a2866bed4be291fa648a1d35929f80f43dae62f40cbfe0142162b0ab49d332db83ba19c58d1da4024b78a264e101c8__webfilesReturnUrlToken_webfiles&action&brand=webfiles"},
            {"name": "AWS Console", "url": "https://us-east-1.signin.aws.amazon.com/oauth?response_type=code&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fhomepage&redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3Fstate%3DhashArgs%2523%26isauthcode%3Dtrue&forceMobileLayout=0&forceMobileApp=0"},
        ]
    },
    {
        "groupName": "Schmiede Bonn",
        "items":[
            {"name": "Mind Map", "shortcutKey": "h", "url": "https://coggle.it/diagram/XPnkTyopRLSeQzgm/t/grimme-data-lab-schmiede-one-bonn"},
            {"name": "First Doc", "shortcutKey": "w", "url": "https://docs.google.com/document/d/1URq7QVODXQpoU2tkoveoLomD2p4wvRoHfTN6lCzpe_k/edit#"},
            {"name": "ML Series", "shortcutKey": "n", "url": "https://www.youtube.com/playlist?list=PLD0F06AA0D2E8FFBA"},
            {"name": "Confernces", "shortcutKey": null, "url": "https://www.kdnuggets.com/meetings/index.html"},
            {"name": "Videos", "shortcutKey": null, "url": "https://www.analyticsvidhya.com/blog/2019/07/11-data-science-videos-every-data-scientist-must-watch/"},
        ]
    }
]

let $container = document.getElementById("content");
let getUrl = {};

let $shortcutDisplayList = document.getElementsByClassName("shortcut");
let listeningForShortcut = false;
let listenerTimeout;

function setupWelcomeMessage(){
    let curHours = new Date().getHours();
    curHours = Math.floor(curHours/6); // Simply dividing current hours by 6 proves to be a good enough aproximation.
    if (curHours == 4) curHours = 3;
    let welcome = "Good " + WELCOME_MESSAGE_TEMPLATE[curHours] + ", " + NAME;
    document.getElementById("welcome-string").innerHTML = welcome;
}

function setupGroups(){
    for (let i = 0; i < MASTER_MAP.length; i++){
        let curGroupData = MASTER_MAP[i];

        let group = document.createElement("div");
        group.className = "group";
        $container.appendChild(group);

        let header = document.createElement("h1");
        header.innerHTML = curGroupData.groupName;
        group.appendChild(header);

        for (let j = 0; j < curGroupData.items.length; j++){
            let curItemData = curGroupData.items[j];

            let pContainer = document.createElement("p");
            group.appendChild(pContainer);

            let link = document.createElement("a");
            link.innerHTML = curItemData.name;
            link.setAttribute("href", curItemData.url);
            pContainer.appendChild(link);

            if (curItemData.shortcutKey !== null && curItemData.shortcutKey !== undefined){
                let shortcutDisplay = document.createElement("span");
                shortcutDisplay.innerHTML = curItemData.shortcutKey;
                shortcutDisplay.className = "shortcut";
                shortcutDisplay.style.animation = "none";
                pContainer.appendChild(shortcutDisplay);

                getUrl[curItemData.shortcutKey] = curItemData.url
            }
        }
    }
}

function shortcutListener(e) {
    let key = e.key.toLowerCase();

    if (listeningForShortcut && getUrl.hasOwnProperty(key)){
        window.location = getUrl[key];
    }

    if (key === SHORTCUT_STARTER) {
        clearTimeout(listenerTimeout);
        listeningForShortcut = true;

        // Animation reset
        for (let i = 0; i < $shortcutDisplayList.length; i++){
            $shortcutDisplayList[i].style.animation = "none";
            setTimeout(function() { $shortcutDisplayList[i].style.animation = ''; }, 10);
        }

        listenerTimeout = setTimeout(function(){ listeningForShortcut = false; }, SHORTCUT_TIMEOUT);
    }

    if (!listeningForShortcut && key === 's') {
        document.getElementById("search").focus();
    }
}

function main(){
    setupWelcomeMessage();
    setupGroups();
    document.addEventListener('keyup', shortcutListener, false);
}

main();
