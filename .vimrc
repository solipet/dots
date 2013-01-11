" Uncomment these lines for running under OSX.
" Necessary to get colors to work in Mac OSX shell.
"if !has("gui") && has("terminfo")
"  set t_Co=16
"  set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
"  set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
"else
"  set t_Co=16
"  set t_Sf=[3%dm
"  set t_Sb=[4%dm
"endif


" Vim Notes:
" ----------
"
" -You can use * in command mode to search for the word under the
"  cursor.  This will search using the word delimiters \< and \>
"  so if you do it over a loop counter variable i, it won't find
"  i in the middle of a word.
"
" -To replace all tabs in a file with spaces, make sure expandtab is
"  set and type :retab in command mode
"
" -To disable vim's auto indenting when pasting text into vim,
"  type :set paste to enter paste mode, then :set nopaste when finished
"
" -To indent a region, highlight it and then press >  To unindent,
"  press <
"
" -To display the search history, type / to begin a search
"  and then hit ctrl-f.  The up and down arrow keys can also
"  be used while searching to scroll through the search history.
"
" - ~/.viminfo is the file that stores vim data between sessions. This
"   is what enables vim to remember the line # you were on if you exit
"   and then reopen the same file. For some reason, my .viminfo became
"   read/write only by root, which caused vim to never remember where I was.
"



"------------------------------------------------------------
" Includes
"------------------------------------------------------------
"
source $VIMRUNTIME/vimrc_example.vim 
source $VIMRUNTIME/filetype.vim 
source $VIMRUNTIME/indent.vim 


"------------------------------------------------------------
" Customize the look of vim
"------------------------------------------------------------

" Don't leave the backup files around
set nobackup

" background color of the window vim's running in
"set background=light
set background=dark

" automatically show matching (, { or [ after matching one is typed
set showmatch

" number of spaces to automatically indent
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Use spaces instead of tabs
set expandtab

" Force file format to always be unix.  If it's allowed to auto-detect
" it will hide all the ^M's because it will think it's a dos file
"set fileformats=mac,unix,dos
set fileformats=unix

" When more than one filename matches during completion, list all 
" matches and complete up until the longest common string (like the shell).
set wildmode=list:longest

"------------------------------------------------------------
" Customizations for compiling 
"------------------------------------------------------------

" Automatically write the current file before a :make
set autowrite

" Automatically cd to the directory of the current file whenever
" a buffer is entered.  see :help filename-modifiers
" This is necessary for ant to work since it searches up from the
" current directory to find the appropriate build.xml file
autocmd BufEnter * cd %:p:h

" This is supposed to make vim open the file at the last edited location but
" it doesn't seem to work.
"au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Fix common spelling mistakes
abbreviate teh the
abbreviate Teh The
abbreviate recieve receive
abbreviate Recieve Receive
abbreviate transcieve transceive
abbreviate Transcieve Transceive

" Used to toggle on/off autoindent when pasting into vim
nmap <F2> :set paste
nmap <F3> :set nopaste

" Used to run the main method of the file being edited
nmap <F6> :!jrun %

" F7 comments out the selected region in visual mode
" F8 comments it back in
au FileType java,c let b:comment_leader = '//'
au FileType sh,make,perl let b:comment_leader = '#'
au FileType vim let b:comment_leader = '"'
vmap <F7> :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
vmap <F8> :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

map ~wf <ESC>:highlight WhiteSpaceEol NONE<CR>

" Replaced by 
" F7 comments out the selected region in visual mode
" F8 comments it back in
"vmap <F7> :s/^/\/\//|:nohlsearch
"vmap <F8> :s/^\/\//|:nohlsearch

"------------------------------------------------------------
" Abbreviations
" imap maps the <code>first param to the rest while in insert mode
" All the ^M characters are entered by typing "Ctrl-v Enter"
" while in insert mode. ^] is the escape key, entered by "Ctrl-v ESC"
" The abbrevs have no indentation since it's assumed cindent is turned on
"------------------------------------------------------------

" Wrap the word under the cursor in a <XXX></XXX> block
" Must be in normal mode (not insert mode) and the
" cursor must be on the first letter of the word to wrap.
nmap ~code i<code>ea</code>
nmap ~iname i<interfacename>ea</interfacename>
nmap ~cname i<classname>ea</classname>
nmap ~meth i<methodname>ea</methodname>
nmap ~emp i<emphasis>ea</emphasis>
nmap ~con i<constant>ea</constant>
nmap ~file i<filename>ea</filename>

" Insert a println and position the cursor between the quotes
imap ~dp System.out.println( "" );gei

" Insert code for doing timing tests
imap ~time long time = System.currentTimeMillis();time = System.currentTimeMillis() - time;System.out.println( "time = " + time + "ms" );

" Insert a pair of opening and closing tags and
" position the cursor in between them.  Must be
" in insert mode to work.
imap ~code <code></code>2ba
imap ~iname <interfacename></interfacename>2ba
imap ~cname <classname></classname>2ba
imap ~meth <methodname></methodname>2ba
imap ~emp <emphasis></emphasis>2ba
imap ~con <constant></constant>2ba
imap ~file <filename></filename>2ba

imap ~li {@link }i

imap ~implug import com.solipsys.dynamicloader.Plugin;

imap ~il EventQueue.invokeLater( new Runnable() {public void run(){}} );kO

imap ~aa addActionListener( new ActionListener() {public void actionPerformed( ActionEvent e ){}} );kO

imap ~ap addPropertyChangeListener( new PropertyChangeListener() {public void propertyChange( PropertyChangeEvent evt ){}} );kO

imap ~ac addChangeListener( new ChangeListener() {public void stateChanged( ChangeEvent e ){}} );kO

imap ~ai addItemListener( new ItemListener() {public void itemStateChanged( ItemEvent e ){if ( e.getStateChange() == ItemEvent.SELECTED ){}}} );2kO

imap ~ad getDocument().addDocumentListener( new DocumentListener() {public void insertUpdate( DocumentEvent e ){}public void removeUpdate( DocumentEvent e ){}public void changedUpdate( DocumentEvent e ){}} );kO

imap ~main public static void main( String[] args ){JPanel panel = new ;JFrame frame = new JFrame( "Test Program" );frame.getContentPane().add( panel , BorderLayout.CENTER );frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );frame.pack();frame.show();}%j$i

imap ~log private final static org.apache.log4j.Logger log =org.apache.log4j.Logger.getLogger( .class );3bi

imap ~scroll JScrollPane scroller = new JScrollPane(  );scroller.getHorizontalScrollBar().setUnitIncrement( 10 );scroller.getVerticalScrollBar().setUnitIncrement( 10 );kkhhi

imap ~hash public int hashCode(){}public boolean equals( Object obj ){}

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

