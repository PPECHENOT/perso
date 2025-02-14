var loadingtext =				'Chargement';
var errortext =					'Erreur ';
var filetext =					'Dossier';
var notfoundtext =				'non trouv\u00E9';

var preferenceslink =			'Options';
var datepickerbutton =			'Allez!';
var earliertext =				'Plus t\u00F4t';
var latertext =					'Plus tard';

var gridtab =					'Grille';
var displayhourslabel =			'Heures \u00E0 Montrer';
	var displayhourshint =		'Choisissez le nombre d\'heures pour montrer.';
var autosizelabel =				'Placez la largeur automatiquement';
	var autosizehint =			'V\u00E9rifiez cette bo\u00EEte pour choisir automatiquement une largeur de table bas\u00E9e sur le nombre de colonnes. Uncheck pour permettre la prochaine bo\u00EEte.';
var tablewidthlabel =			'Largeur de table (en Pixel)';
	var tablewidthhint =		'Indiquez la largeur de la table en Pixel. V\u00E9rifiez la bo\u00EEte ci-dessus pour placer ceci automatiquement.';
var offsetminuteslabel =		'Commencez par l\'heure suivante apr\u00E8s';
	var offsetminuteshint =		'Placez la partie de minutes de l\'heure apr\u00E8s quoi la grille commencera par l\'heure suivante sur la charge initiale.';
var refreshonthelabel =			'R\u00e9g\u00e9n\u00e9rez chaque heure \u00e0';
	var refreshonthehint =		'XSLTv peut automatiquement r\u00e9g\u00e9n\u00e9rer les listes chaque heure pour maintenir la grille \u00e0 jour, si le navigateur est maintenu ouvert. Choisissez la minute chaque heure d\'effectuer la r\u00e9g\u00e9n\u00e9ration'
	var norefreshoption =		'Ne r\u00e9g\u00e9n\u00e9rez pas';
var timebarfrequencylabel = 	'Time Bar Frequency';
	var timebarfrequencyhint =	'How often to repeat the time header row.';
	var toponlyoption =			'Top Line Only';
	
var popupstab =					'Popup';
var channelpopupslabel =		'Popup de canal';
	var channelpopupshint =		'V\u00E9rifiez cette bo\u00EEte pour permettre les popup quand la souris est au-dessus des noms de canal.';
var descriptionpopupslabel =	'Popup de programme';
	var descriptionpopupshint =	'V\u00E9rifiez cette bo\u00EEte pour permettre les popup quand la souris est au-dessus d\'un programme.';
var popupdelaylabel =			'Retardez le popup (en ms)';
	var popupdelayhint =		'Placez les millisecondes d\'en de retarder avant que les popup apparaissent. L\'ensemble \u00E0 0 \u00E0 neutraliser retardent.';
var popuptimeslabel =			'P\u00E9riodes';
	var popuptimeshint =		'V\u00E9rifiez cette bo\u00EEte pour montrer des temps de d\u00E9but et de fin dans les popup de programme.';
var popupratinglabel =			'Estimation';
	var popupratinghint =		'V\u00E9rifiez pour montrer des estimations de MPAA dans les popup de programme.';
var popupsubtitlelabel =		'Sous-titre';
	var popupsubtitlehint =		'V\u00E9rifiez pour montrer des sous-titres de programme dans les popup de programme.';
var popupdescriptionlabel =		'Description';
	var popupdescriptionhint =	'V\u00E9rifiez pour montrer des descriptions de programme dans les popup de programme.';
var popupdatelabel =			'Date';
	var popupdatehint =			'V\u00E9rifiez pour montrer des dates dans les popup de programme. Les dates sont des dates de d\u00E9gagement pour des films ou des dates premier-a\u00E9r\u00E9es pour des expositions.';
var popupcategorieslabel =		'Cat\u00E9gories';
	var popupcategorieshint =	'Contr\u00F4le pour montrer des cat\u00E9gories ou des genres d\'exposition dans les popup de programme.';
var popupstarratinglabel =		'\u00C9valuation dans \u00E9toile';
	var popupstarratinghint =	'V\u00E9rifiez pour montrer une estimation graphique dans \u00E9toile dans les popup de programme.';

var localoptionstab =			'Options localis\u00E9es';
var languagelabel =				'Langue';
var fixgapslabel =				'Remplissez trous dans les listes';
	var fixgapshint =			'V\u00E9rifiez pour permettre l\'espace-d\u00E9tection dans les listes qui ne sont pas contigu\u00EBs. Cette option exige des listes d\'\u00EAtre assorties avec --by-channel pour travailler. Cette option fera charger des listes beaucoup plus lentement, ainsi ne v\u00E9rifie pas inutilement.';
	var fixgapsconfirm =		'Pour remplir lacunes dans les listes, assurez svp le dossier de XML a \u00E9t\u00E9 assorti avec l\'option --by-channel!';
var absoluteiconslabel =		'R\u00E9f\u00E9rences absolues d\'ic\u00F4ne';
	var absoluteiconshint =		'XSLTv recherche des ic\u00F4nes de canal dans des \'icons\' chemise. V\u00E9rifiez cette bo\u00EEte si votre dossier de xml contient des r\u00E9f\u00E9rences de Absolute URL aux ic\u00F4nes.';
var dayfirstlabel =				'Jour est \u00E9crit d\'abord en dates';
	var dayfirsthint =			'V\u00E9rifiez cette bo\u00EEte pour montrer des dates dans le format de JJ/MM/AAAA. Uncheck pour le format de MM/JJ/AAAA.';
var grabberlabel =				'Agrippeur: tv_grab_';
	var grabberhint =			'Choisissez votre agrippeur appliquer de divers arrangements localis\u00E9s.';

var otheroptionstab =			'D\'autres options';
var loadonclicklabel =			'En double cliquant:';
	var loadonclicknothing =	'Ne rien faire';
	var loadonclickIMDB =		'Recherche TMDB';
	var loadonclickURL =		'URL dans XML';
var categorycolorslabel =		'Colorez les cat\u00E9gories';
	var categorycolorshint=		'Choisissez pour permettre accentuer de cat\u00E9gorie (des couleurs doivent \u00EAtre d\u00E9finies dans des dossiers de CSS). Ne pas s\u00E9lectionner pour une petite am\u00E9lioration de vitesse.';
var dailyfileslabel =			'Employez les dossiers quotidiens';
	var dailyfileshint=			'Choisissez pour employer les dossiers quotidiens dans le format AAAAMMJJ.xml au lieu d\'un dossier simple de tv.xml.';
var highlightclickablelabel =	'Highlight linked programs';
	var highlightclickablehint ='Highlight programs which are linked to a URL (set above). The type of highlighting depends on the stylesheet. It is recommended to disable this if all programs are to be links, or if none are.';
var highlightmovieslabel =		'Highlight movies rated at or over:';
	var highlightmovieshint =	'Highlight movies rated at or over this number of stars. The type of highlighting depends on the stylesheet, but is generally a brighter color. This is separate from the category highlighting below.';
var highlightnewlabel =			'Highlight new shows';
	var highlightnewhint =		'Highlight shows which are airing for the first time. The highlighting is generally a darker or thicker border.';
var printdateslabel =			'Show movie release dates';
	var printdateshint =		'Show movie release dates in the grid. This is separate from the dates in the popup, and only applies to movies.';
var twelvehourlabel =			'Use twelve-hour clock';
	var twelvehourhint =		'Use twelve-hour (with AM and PM) instead of twenty-four-hour clock.';
var showclocklabel =			'Show clock in upper right';
	var showclockhint =			'Check to show current time and date in the top right of page.';
var showbarclocklabel =			'Show clock in top bar';
	var showbarclockhint =		'Check to show current time in the top bar.';

var reloadbutton =				'Recharge';

var monthnames =				new Array('janvier', 'f\u00E9vrier', 'mars', 'avril', 'mai', 'juin', 'juillet', 'ao\u00FBt', 'septembre', 'octobre', 'novembre', 'd\u00E9cembre')
var daynames =					new Array('dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi');
var dayletters =				new Array('D', 'L', 'M', 'M', 'J', 'V', 'S');

var alllabel =					'Tous';
var nonelabel =					'Aucun';