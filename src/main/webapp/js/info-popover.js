function animInfoPopoverForList() {
    //add
    var duration = 2500;
    var time = 0;
    var finish = duration;


    showPopover('#navi li:eq(0) button', time, finish, {
        placement: 'bottom',
        content: 'Click here if want add new user'
    })
    time += duration; //2000
    finish += duration; //4000
    showPopover('#navi  li:eq(1) button', time, finish, {
        placement: 'bottom',
        content: 'Click here if you want look your profile'
    })
    time += duration;
    finish += duration;
    showPopover('#navi li:eq(2) button', time, finish, {
        placement: 'bottom',
        content: 'Click here if you want sign out'
    })

    time += duration;
    finish += duration;
    showPopover('tbody tr:first-child', time, finish, {
        placement: 'bottom',
        content: 'Click here if you want look this profile'
    });
    time += duration;
    finish += duration;
    showPopover('tbody tr:first-child td:last-child button', time, finish, {
        placement: 'bottom',
        content: 'Click here if you want remove this profile'
    })
}
function showPopover(adr, time, duration, options) {
    var cls = 'bg-info text-white';
    setTimeout(()=> {
            $(adr).popover(options).popover('show');
            $(adr).addClass(cls);
        }
        , time);
    setTimeout(()=> {
        $(adr).popover('dispose');
        $(adr).removeClass(cls);
    }, duration);
}