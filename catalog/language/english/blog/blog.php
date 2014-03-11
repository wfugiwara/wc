<?php
// Text
$_['text_home']            = 'Home';
$_['text_blog']            = 'Blog';
$_['text_error_art']       = 'Blog article is empty!';
$_['text_error_cat']       = 'Blog category not found!';


// Article & Category Info
$_['text_subcategory']     = 'Sub-Category';
$_['text_art_infoName']    = 'Posted by <span itemprop="author">%s</span>';
$_['text_art_infoCategory']= ' in <span itemprop="articleSection">%s</span>';
$_['text_art_InfoDate']    = ' on <span itemprop="dateCreated">%s</span>';
$_['text_update']          = 'Last update: ';
$_['text_tags']            = 'Tags: ';
$_['text_related']         = 'Related Posts: ';
$_['text_related_product'] = 'Related Products: ';
$_['text_related_article'] = 'Related Article ';

// Comment
$_['text_comments']        = '%s Comments';
$_['text_replies']         = '(%s Replies)';
$_['text_comment']         = 'Comments';
$_['text_no_comment']      = 'No Comments';
$_['text_postComment']     = 'Leave a Comment';
$_['text_postReply']       = 'Leave a Reply';
$_['text_no_comments']     = 'No comment yet, be the first to comment!';
$_['text_note_publish']    = '(Not Published)';
$_['text_note_website']    = '(Site url with http://)';
$_['text_wait']            = 'Please wait!';
$_['button_submit']        = 'Submit';
$_['text_success']         = 'Thank you for your comment.';
$_['text_approval']        = 'Your comment successfully submitted for approval.';
$_['text_reply']           = 'Reply';
$_['text_cancel_reply']    = 'Cancel Reply';

// Comment Entry
$_['entry_name']           = 'Name: ';
$_['entry_email']          = 'E-mail: ';
$_['entry_site']           = 'Website: ';
$_['entry_comment']        = 'Comment: ';
$_['entry_captcha']        = 'Verification code: ';
$_['text_login_comment']   = 'Attention: You need to <a href="%s">logged in</a> to comment!';

//Mail Notification
$_['text_mail_subject']    = '[%s] New Comment on Article: "%s"';
$_['text_mail_greeting']   = 'New comments have been posted on <a href="%s" target="_blank" title="%s">%s</a> article.<br /><br />';
$_['text_mail_article']    = '<b>Article:</b>';
$_['text_mail_article1']   = '<a href="%s" target="_blank" title="%s">%s</a>';
$_['text_mail_name']       = '<b>Author:</b>';
$_['text_mail_mail']       = '<b>E-mail:</b>';
$_['text_mail_mail1']      = '<a href="mailto:%s">%s</a>';
$_['text_mail_url']        = '<b>Url:</b>';
$_['text_mail_url1']       = '<a href="%s" target="_blank" title="%s">%s</a><br />';
$_['text_mail_message']    = '<b>Comment:</b>';
$_['text_mail_footer']     = '<br /><br />You can see all comments on this post here:';
$_['text_mail_footer1']    = '<a href="%s" target="_blank" title="%s">%s</a><br /><br />';

// Search
$_['text_search_blog']     = 'Blog Search Result';
$_['text_search_result']   = 'There is no article that matches the search criteria.';
$_['text_search_more']     = 'more..';


// Error
$_['error_common']         = 'Warning: Please check required form bellow!';
$_['error_name']           = 'Name between 2 - 25 characters !';
$_['error_email']          = 'E-mail address not valid !';
$_['error_content']        = 'Comment must be between %s and %s characters!';
$_['error_captcha']        = 'Verification code does not match the image!';

$_['read_more']            = 'Read more..';
$_['day_short']            = array(1 => "Mon", 2 => "Tue", 3 => "Wed", 4 => "Thu", 5 => "Fri", 6 => "Sat",7 => "Sun");
$_['day_long']             = array(1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday", 7 => "Sunday");
$_['month_short']          = array(1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr", 5 => "May", 6 => "Jun", 7 => "Jul", 8 => "Aug", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec");
$_['month_long']           = array(1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December");

// Date Format
// %1 = long month, %2 = short month, %3 = long day, %4 = short day
// other format except the month and dayname above still use http://php.net/manual/en/function.date.php

$_['date_format']          = 'F d, Y';
$_['date_format_short']    = '%2 d, Y'; // M d, Y = Jun 10, 2013
$_['date_format_long']     = '%1 d, Y'; // F d, Y = Juni 10, 2013
$_['date_time_format']     = '%1 d, Y H:i'; // M d, Y H:i = Jun 10, 2013 17:25
?>