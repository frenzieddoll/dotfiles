;;; flim-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "eword-decode" "../../../../../.emacs.d/elpa/flim-20190526.1034/eword-decode.el"
;;;;;;  "48d4cc1f8dd0b191dcdb352638601d56")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/eword-decode.el

(autoload 'mime-set-field-decoder "eword-decode" "\
Set decoder of FIELD.
SPECS must be like `MODE1 DECODER1 MODE2 DECODER2 ...'.
Each mode must be `nil', `plain', `wide', `summary' or `nov'.
If mode is `nil', corresponding decoder is set up for every modes.

\(fn FIELD &rest SPECS)" nil nil)

(autoload 'mime-find-field-presentation-method "eword-decode" "\
Return field-presentation-method from NAME.
NAME must be `plain', `wide', `summary' or `nov'.

\(fn NAME)" nil t)

(autoload 'mime-find-field-decoder "eword-decode" "\
Return function to decode field-body of FIELD in MODE.
Optional argument MODE must be object or name of
field-presentation-method.  Name of field-presentation-method must be
`plain', `wide', `summary' or `nov'.
Default value of MODE is `summary'.

\(fn FIELD &optional MODE)" nil nil)

(autoload 'mime-update-field-decoder-cache "eword-decode" "\
Update field decoder cache `mime-field-decoder-cache'.

\(fn FIELD MODE &optional FUNCTION)" nil nil)

(autoload 'mime-decode-field-body "eword-decode" "\
Decode FIELD-BODY as FIELD-NAME in MODE, and return the result.
Optional argument MODE must be `plain', `wide', `summary' or `nov'.
Default mode is `summary'.

If MODE is `wide' and MAX-COLUMN is non-nil, the result is folded with
MAX-COLUMN.

Non MIME encoded-word part in FILED-BODY is decoded with
`default-mime-charset'.

\(fn FIELD-BODY FIELD-NAME &optional MODE MAX-COLUMN)" nil nil)

(autoload 'mime-decode-header-in-region "eword-decode" "\
Decode MIME encoded-words in region between START and END.
If CODE-CONVERSION is nil, it decodes only encoded-words.  If it is
mime-charset, it decodes non-ASCII bit patterns as the mime-charset.
Otherwise it decodes non-ASCII bit patterns as the
default-mime-charset.

\(fn START END &optional CODE-CONVERSION)" t nil)

(autoload 'mime-decode-header-in-buffer "eword-decode" "\
Decode MIME encoded-words in header fields.
If CODE-CONVERSION is nil, it decodes only encoded-words.  If it is
mime-charset, it decodes non-ASCII bit patterns as the mime-charset.
Otherwise it decodes non-ASCII bit patterns as the
default-mime-charset.
If SEPARATOR is not nil, it is used as header separator.

\(fn &optional CODE-CONVERSION SEPARATOR)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "eword-decode"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/eword-decode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/eword-decode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "eword-decode" '("eword-" "mime-")))

;;;***

;;;***

;;;### (autoloads nil "eword-encode" "../../../../../.emacs.d/elpa/flim-20190526.1034/eword-encode.el"
;;;;;;  "29e57995ef316196603f489f4be4d6af")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/eword-encode.el

(autoload 'mime-encode-field-body "eword-encode" "\
Encode FIELD-BODY as FIELD-NAME, and return the result.
A lexical token includes non-ASCII character is encoded as MIME
encoded-word.  ASCII token is not encoded.

\(fn FIELD-BODY FIELD-NAME)" nil nil)

(autoload 'mime-encode-header-in-buffer "eword-encode" "\
Encode header fields to network representation, such as MIME encoded-word.
It refers the `mime-field-encoding-method-alist' variable.

\(fn &optional CODE-CONVERSION)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "eword-encode"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/eword-encode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/eword-encode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "eword-encode" '("ew-" "eword-" "tm-eword::encoded-word-length" "mime-header-" "make-ew-rword")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "hex-util" "../../../../../.emacs.d/elpa/flim-20190526.1034/hex-util.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/hex-util.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hex-util" '("encode-hex-string" "decode-hex-string")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "hmac-def" "../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-def.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-def.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hmac-def" '("define-hmac-function")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "hmac-md5" "../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-md5.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-md5.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hmac-md5" '("hmac-md5")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "hmac-sha1" "../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-sha1.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-sha1.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hmac-sha1" '("hmac-sha1")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "luna" "../../../../../.emacs.d/elpa/flim-20190526.1034/luna.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/luna.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "luna" '("luna-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "lunit" "../../../../../.emacs.d/elpa/flim-20190526.1034/lunit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/lunit.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lunit" '("lunit")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "md4" "../../../../../.emacs.d/elpa/flim-20190526.1034/md4.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/md4.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "md4" '("md4")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "md5" "../../../../../.emacs.d/elpa/flim-20190526.1034/md5.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/md5.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "md5" '("md5-dl-module")))

;;;***

;;;### (autoloads nil "mel" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel.el"
;;;;;;  "799afced9a1939215ee07ede4a005974")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel.el

(autoload 'mime-encode-region "mel" "\
Encode region START to END of current buffer using ENCODING.
ENCODING must be string.

\(fn START END ENCODING)" t nil)

(autoload 'mime-decode-region "mel" "\
Decode region START to END of current buffer using ENCODING.
ENCODING must be string.

\(fn START END ENCODING)" t nil)

(autoload 'mime-decode-string "mel" "\
Decode STRING using ENCODING.
ENCODING must be string.  If ENCODING is found in
`mime-string-decoding-method-alist' as its key, this function decodes
the STRING by its value.

\(fn STRING ENCODING)" nil nil)

(autoload 'mime-insert-encoded-file "mel" "\
Insert file FILENAME encoded by ENCODING format.

\(fn FILENAME ENCODING)" t nil)

(autoload 'mime-write-decoded-region "mel" "\
Decode and write current region encoded by ENCODING into FILENAME.
START and END are buffer positions.

\(fn START END FILENAME ENCODING)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "mel" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mel" '("Q-encod" "binary-" "base64-encoded-length" "encoded-text-encode-string" "mime-encoding-" "mel-" "7bit-" "8bit-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mel-b-ccl" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-b-ccl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel-b-ccl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mel-b-ccl" '("base64-" "mel-ccl-encode-b")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mel-b-el" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-b-el.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel-b-el.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mel-b-el" '("base64-" "pack-sequence")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mel-g" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-g.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel-g.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mel-g" '("gzip64-external-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mel-q" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-q.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel-q.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mel-q" '("quoted-printable-" "q-encoding-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mel-q-ccl" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-q-ccl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel-q-ccl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mel-q-ccl" '("mel-ccl-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mel-u" "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-u.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mel-u.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mel-u" '("uuencode-external-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mime" "../../../../../.emacs.d/elpa/flim-20190526.1034/mime.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mime.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mime" '("mime-")))

;;;***

;;;### (autoloads nil "mime-conf" "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-conf.el"
;;;;;;  "03db45ea337c9059774e85aaa85769a5")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mime-conf.el

(autoload 'mime-parse-mailcap-buffer "mime-conf" "\
Parse BUFFER as a mailcap, and return the result.
If optional argument ORDER is a function, result is sorted by it.
If optional argument ORDER is not specified, result is sorted original
order.  Otherwise result is not sorted.

\(fn &optional BUFFER ORDER)" nil nil)

(defvar mime-mailcap-file "~/.mailcap" "\
*File name of user's mailcap file.")

(autoload 'mime-parse-mailcap-file "mime-conf" "\
Parse FILENAME as a mailcap, and return the result.
If optional argument ORDER is a function, result is sorted by it.
If optional argument ORDER is not specified, result is sorted original
order.  Otherwise result is not sorted.

\(fn &optional FILENAME ORDER)" nil nil)

(autoload 'mime-format-mailcap-command "mime-conf" "\
Return formated command string from MTEXT and SITUATION.

MTEXT is a command text of mailcap specification, such as
view-command.

SITUATION is an association-list about information of entity.  Its key
may be:

	'type		primary media-type
	'subtype	media-subtype
	'filename	filename
	STRING		parameter of Content-Type field

\(fn MTEXT SITUATION)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "mime-conf" "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-conf.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mime-conf.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mime-conf" '("mime-mailcap-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mime-def" "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-def.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mime-def.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mime-def" '("base64-" "make-mime-content-" "mime-" "mel-" "Q-encoded-text-regexp" "quoted-printable-" "B-encoded-text-regexp" "regexp-")))

;;;***

;;;### (autoloads nil "mime-parse" "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-parse.el"
;;;;;;  "d924e646e8b634ab263c047dad6a5e27")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mime-parse.el

(autoload 'mime-parse-Content-Type "mime-parse" "\
Parse FIELD-BODY as a Content-Type field.
FIELD-BODY is a string.
Return value is a mime-content-type object.
If FIELD-BODY is not a valid Content-Type field, return nil.

\(fn FIELD-BODY)" nil nil)

(autoload 'mime-read-Content-Type "mime-parse" "\
Parse field-body of Content-Type field of current-buffer.
Return value is a mime-content-type object.
If Content-Type field is not found, return nil.

\(fn)" nil nil)

(autoload 'mime-parse-Content-Disposition "mime-parse" "\
Parse FIELD-BODY as a Content-Disposition field.
FIELD-BODY is a string.
Return value is a mime-content-disposition object.
If FIELD-BODY is not a valid Content-Disposition field, return nil.

\(fn FIELD-BODY)" nil nil)

(autoload 'mime-read-Content-Disposition "mime-parse" "\
Parse field-body of Content-Disposition field of current-buffer.
Return value is a mime-content-disposition object.
If Content-Disposition field is not found, return nil.

\(fn)" nil nil)

(autoload 'mime-parse-Content-Transfer-Encoding "mime-parse" "\
Parse FIELD-BODY as a Content-Transfer-Encoding field.
FIELD-BODY is a string.
Return value is a string.
If FIELD-BODY is not a valid Content-Transfer-Encoding field, return nil.

\(fn FIELD-BODY)" nil nil)

(autoload 'mime-read-Content-Transfer-Encoding "mime-parse" "\
Parse field-body of Content-Transfer-Encoding field of current-buffer.
Return value is a string.
If Content-Transfer-Encoding field is not found, return nil.

\(fn)" nil nil)

(autoload 'mime-parse-msg-id "mime-parse" "\
Parse TOKENS as msg-id of Content-ID or Message-ID field.

\(fn TOKENS)" nil nil)

(autoload 'mime-uri-parse-cid "mime-parse" "\
Parse STRING as cid URI.

\(fn STRING)" nil nil)

(autoload 'mime-parse-buffer "mime-parse" "\
Parse BUFFER as a MIME message.
If buffer is omitted, it parses current-buffer.

\(fn &optional BUFFER REPRESENTATION-TYPE)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "mime-parse" "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-parse.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mime-parse.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mime-parse" '("mime-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mmbuffer" "../../../../../.emacs.d/elpa/flim-20190526.1034/mmbuffer.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mmbuffer.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mmbuffer" '("mmbuffer-parse-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mmexternal" "../../../../../.emacs.d/elpa/flim-20190526.1034/mmexternal.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mmexternal.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mmexternal" '("mmexternal-require-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "mmgeneric" "../../../../../.emacs.d/elpa/flim-20190526.1034/mmgeneric.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/mmgeneric.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mmgeneric" '("mm-" "mime-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "ntlm" "../../../../../.emacs.d/elpa/flim-20190526.1034/ntlm.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/ntlm.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ntlm" '("ntlm-")))

;;;***

;;;### (autoloads nil "qmtp" "../../../../../.emacs.d/elpa/flim-20190526.1034/qmtp.el"
;;;;;;  "f4e48b8a4f585bd2beec39d08f589e4c")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/qmtp.el

(defvar qmtp-open-connection-function #'open-network-stream)

(autoload 'qmtp-via-qmtp "qmtp" "\


\(fn SENDER RECIPIENTS BUFFER)" nil nil)

(autoload 'qmtp-send-buffer "qmtp" "\


\(fn SENDER RECIPIENTS BUFFER)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "qmtp" "../../../../../.emacs.d/elpa/flim-20190526.1034/qmtp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/qmtp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "qmtp" '("qmtp-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "sasl" "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sasl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sasl" '("sasl-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "sasl-cram" "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-cram.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-cram.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sasl-cram" '("sasl-cram-md5-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "sasl-digest"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-digest.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-digest.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sasl-digest" '("sasl-digest-md5-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "sasl-ntlm" "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-ntlm.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-ntlm.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sasl-ntlm" '("sasl-ntlm-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "sasl-scram" "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-scram.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-scram.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sasl-scram" '("sasl-scram-md5-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "sasl-xoauth2"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-xoauth2.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-xoauth2.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sasl-xoauth2" '("sasl-xoauth2-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "sha1" "../../../../../.emacs.d/elpa/flim-20190526.1034/sha1.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sha1.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sha1" '("sha1-dl-module")))

;;;***

;;;### (autoloads nil "sha1-el" "../../../../../.emacs.d/elpa/flim-20190526.1034/sha1-el.el"
;;;;;;  "784272062c9508e0f5c03971da46aa82")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sha1-el.el

(autoload 'sha1 "sha1-el" "\
Return the SHA1 (Secure Hash Algorithm) of an object.
OBJECT is either a string or a buffer.
Optional arguments BEG and END denote buffer positions for computing the
hash of a portion of OBJECT.
If BINARY is non-nil, return a string in binary form.

\(fn OBJECT &optional BEG END BINARY)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "sha1-el" "../../../../../.emacs.d/elpa/flim-20190526.1034/sha1-el.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/sha1-el.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sha1-el" '("sha1-")))

;;;***

;;;***

;;;### (autoloads nil "smtp" "../../../../../.emacs.d/elpa/flim-20190526.1034/smtp.el"
;;;;;;  "0ff4aa31a28197f7bfd1ae2f1b5661d0")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/smtp.el

(defvar smtp-open-connection-function #'open-network-stream "\
*Function used for connecting to a SMTP server.
The function will be called with the same four arguments as
`open-network-stream' and should return a process object.
Here is an example:

\(setq smtp-open-connection-function
      #'(lambda (name buffer host service)
	  (let ((process-connection-type nil))
	    (start-process name buffer \"ssh\" \"-C\" host
			   \"nc\" host service))))

It connects to a SMTP server using \"ssh\" before actually connecting
to the SMTP port.  Where the command \"nc\" is the netcat executable;
see http://www.atstake.com/research/tools/index.html#network_utilities
for details.")

(autoload 'smtp-via-smtp "smtp" "\
Like `smtp-send-buffer', but sucks in any errors.

\(fn SENDER RECIPIENTS BUFFER)" nil nil)

(autoload 'smtp-send-buffer "smtp" "\
Send a message.
SENDER is an envelope sender address.
RECIPIENTS is a list of envelope recipient addresses.
BUFFER may be a buffer or a buffer name which contains mail message.

\(fn SENDER RECIPIENTS BUFFER)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "smtp" "../../../../../.emacs.d/elpa/flim-20190526.1034/smtp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/smtp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "smtp" '("smtp-")))

;;;***

;;;***

;;;### (autoloads nil "std11" "../../../../../.emacs.d/elpa/flim-20190526.1034/std11.el"
;;;;;;  "f4e2d4c7ecf75e8fa4206e6c3dafacd2")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/std11.el

(autoload 'std11-fetch-field "std11" "\
Return the value of the header field NAME.
The buffer is expected to be narrowed to just the headers of the message.

\(fn NAME)" nil nil)

(autoload 'std11-narrow-to-header "std11" "\
Narrow to the message header.
If BOUNDARY is not nil, it is used as message header separator.

\(fn &optional BOUNDARY)" nil nil)

(autoload 'std11-field-body "std11" "\
Return the value of the header field NAME.
If BOUNDARY is not nil, it is used as message header separator.

\(fn NAME &optional BOUNDARY)" nil nil)

(autoload 'std11-unfold-string "std11" "\
Unfold STRING as message header field.

\(fn STRING)" nil nil)

(autoload 'std11-lexical-analyze "std11" "\
Analyze STRING as lexical tokens of STD 11.

\(fn STRING &optional ANALYZER START)" nil nil)

(autoload 'std11-address-string "std11" "\
Return string of address part from parsed ADDRESS of RFC 822.

\(fn ADDRESS)" nil nil)

(autoload 'std11-full-name-string "std11" "\
Return string of full-name part from parsed ADDRESS of RFC 822.

\(fn ADDRESS)" nil nil)

(autoload 'std11-msg-id-string "std11" "\
Return string from parsed MSG-ID of RFC 822.

\(fn MSG-ID)" nil nil)

(autoload 'std11-fill-msg-id-list-string "std11" "\
Fill list of msg-id in STRING, and return the result.

\(fn STRING &optional COLUMN)" nil nil)

(autoload 'std11-parse-address-string "std11" "\
Parse STRING as mail address.

\(fn STRING)" nil nil)

(autoload 'std11-parse-addresses-string "std11" "\
Parse STRING as mail address list.

\(fn STRING)" nil nil)

(autoload 'std11-parse-msg-id-string "std11" "\
Parse STRING as msg-id.

\(fn STRING)" nil nil)

(autoload 'std11-parse-msg-ids-string "std11" "\
Parse STRING as `*(phrase / msg-id)'.

\(fn STRING)" nil nil)

(autoload 'std11-extract-address-components "std11" "\
Extract full name and canonical address from STRING.
Returns a list of the form (FULL-NAME CANONICAL-ADDRESS).
If no name can be extracted, FULL-NAME will be nil.

\(fn STRING)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "std11" "../../../../../.emacs.d/elpa/flim-20190526.1034/std11.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/flim-20190526.1034/std11.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "std11" '("std11-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/flim-20190526.1034/eword-decode.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/eword-encode.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/flim-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/flim-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/hex-util.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-def.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-md5.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/hmac-sha1.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/luna.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/lunit.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/md4.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/md5.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-b-ccl.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-b-el.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-g.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-q-ccl.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-q.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mel-u.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mel.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-conf.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-def.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mime-parse.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mime.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mmbuffer.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mmcooked.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mmexternal.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/mmgeneric.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/ntlm.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/qmtp.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-cram.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-digest.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-ntlm.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-scram.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl-xoauth2.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sasl.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sha1-el.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/sha1.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/smtp.el"
;;;;;;  "../../../../../.emacs.d/elpa/flim-20190526.1034/std11.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; flim-autoloads.el ends here
