// try to simplify, wrap long if statements in separate block

$(document).ready(function () {
    $('.parallax').parallax();

    // initiate parallax

    setTimeout(function(){
      $(".intro_header_text").show().addClass("animated fadeIn");
    }, 1000);

    setTimeout(function(){
      $(".navbar").show().addClass("animated slideInDown");
    }, 1900);

    // Initiate parallax on intro image and animate navbar and text

     $('#skillset').find('div').each(function(){
        InitiateBar(document.getElementById($(this).attr("id")));
    });

    // initiate empty skill bars on page load

    $(document).on("scroll", onScroll);
    
    $('a[href^="#"]').on('click', function (e) {
        $(".navbar-fixed-top").addClass("scrolled");
        $(".navbar-right").addClass("scrolled");
        e.preventDefault();
        $(document).off("scroll");
        
        $('a').each(function () {
            $(this).removeClass('active');
        })
        $(this).addClass('active');
      
        var target = this.hash,
        $target = $(target);
        $('html, body').stop().animate({
            'scrollTop': $target.offset().top-75
        }, 750, 'swing', function () {
            $(document).on("scroll", onScroll);
        });
    });

    // initiate loading links to activate/deactivate navbar links on click, take user to section on click
});

function onScroll(event){
    if($(document).scrollTop() > 50) {
      $(".navbar-fixed-top").addClass("scrolled");
      $(".navbar-right").addClass("scrolled");
    } else {
      $(".navbar-fixed-top").removeClass("scrolled");
      $(".navbar-right").removeClass("scrolled");
    }

    // Transparency toggle on navbar on scroll

    var scrollPos = $(document).scrollTop();
    $('#nav-right a').each(function () {
        var currLink = $(this);
        var refElement = $(currLink.attr("href"));
        if (refElement.position().top - 95 <= scrollPos && refElement.position().top - 95 + refElement.height() > scrollPos) {
            $('#nav-right ul li a').removeClass("active");
            currLink.addClass("active");
        }
        else {
            currLink.removeClass("active");
        }
    });

    // Activate/deactivate link if section is at top of user's page

    var skillsElement = $("#skills")

    if ((!skillsElement.hasClass('skills_activated')) && (skillsElement.position().top - 300 <= scrollPos && skillsElement.position().top - 300 + skillsElement.height() > scrollPos)) {
        $('#skillset').find('div').each(function(){
            var skill = document.getElementById($(this).attr("id"));
            skill.innerHTML = '';
            // clear empty loaded progress bar
            var bar = new InitiateBar(skill);
            bar.animate(skill.dataset.proficiency);
        });
        skillsElement.addClass("skills_activated");
    }

    // Initiate skill section animation if skill section is within user's page

    var imageElement = $("#image_manipulation")

    if ((!imageElement.hasClass('image_manipulation_activated')) && (imageElement.position().top - 150 <= scrollPos && imageElement.position().top - 150 + imageElement.height() > scrollPos)) {
        $.get("/pages/image_manipulation", { 
        });
        imageElement.addClass("image_manipulation_activated");
    }

    // Initiate skill section animation if skill section is within user's page
}

function InitiateBar(skill_section) {
    return bar = new ProgressBar.Line(skill_section, {
      strokeWidth: 0.2,
      easing: 'easeInOut',
      duration: 1400,
      color: '#64aff4',
      trailColor: '#eee',
      trailWidth: 1,
      svgStyle: {width: '100%', height: '1%'}
    });
}

$(".btn_resume").click(function() {
    window.location = '/public/assets/Christopher_Ching_resume.pdf';
});

// Constructor for the progress bar constructor


;
