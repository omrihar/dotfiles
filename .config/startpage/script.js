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
            {"name": "Maps", "shortcutKey": "m", "url": "https://maps.google.com"}
        ]
    },
    {
        "groupName": "Work",
        "items":[
            {"name": "Github", "shortcutKey": "g", "url": "https://github.com/schmiedeone"},
            {"name": "JIRA CNHI", "shortcutKey": "j", "url": "https://schmiedeone.atlassian.net/jira/software/projects/CK/boards/30"},
            {"name": "Confluence CNHI", "shortcutKey": "d", "url": "https://schmiedeone.atlassian.net/wiki/spaces/C/pages/edit/1041596417?draftId=1041268744&draftShareId=b2f590b7-d06f-4020-a79d-39dd5a9f24fc&"},
            {"name": "GitKraken", "shortcutKey": "l", "url": "gitkraken://test"},
            {"name": "Mongo Compass", "shortcutKey": "a", "url": "mc://test"},

        ]
    },
    {
        "groupName": "Personal",
        "items":[
            {"name": "Haaretz", "shortcutKey": "h", "url": "https://www.haaretz.co.il"},
            {"name": "Weather", "shortcutKey": "w", "url": "https://www.accuweather.com/en/de/bonn/53111/weather-forecast/170369"},
            {"name": "Netflix", "shortcutKey": "n", "url": "https://www.netflix.com"}
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

            let shortcutDisplay = document.createElement("span");
            shortcutDisplay.innerHTML = curItemData.shortcutKey;
            shortcutDisplay.className = "shortcut";
            shortcutDisplay.style.animation = "none";
            pContainer.appendChild(shortcutDisplay);

            getUrl[curItemData.shortcutKey] = curItemData.url
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
