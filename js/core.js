var core = {
    init: function () {
        this._setupInputs();

        var self = this;
        $("#enviar").click(function() {
            self.validate() && self.send({
                nome: $("#nome").val(),
                email: $("#email").val(),
                telefone: $("#telefone").val(),
                mensagem: $("#mensagem").val()
            });
        });
    },
    _setupInputs: function () {
        $("input:text,textarea").each(function (i, el) {
            $(el).val($(el).data("default"));
        }).focus(function () {
            if ($(this).val() == $(this).data("default"))
                $(this).val('');
        }).focusout(function () {
            if (!$(this).val())
                $(this).val($(this).data("default"));
        });
        
        $("#telefone").focus(function () {
            $(this).mask("(99) 9999-9999?9");
        });
        $("#telefone").focusout(function () {
            var phone, element;
            element = $(this);
            element.unmask();
            phone = element.val().replace(/\D/g, '');
            if (phone.length > 10) {
                element.mask("(99) 99999-999?9");
            } else {
                element.mask("(99) 9999-9999?9");
            }
        });
    },
    validate: function () {
        var $nome = $("#nome"),
            $email = $("#email"),
            $msg = $("#mensagem"),
            pass = true;

        if (!$nome.val() || $nome.val() == $nome.data("default")) {
            this._mandatory($nome);
            pass = false;
        }
        if (!$email.val() || $email.val() == $email.data("default")) {
            this._mandatory($email);
            pass = false;
        }
        if (!$msg.val() || $msg.val() == $msg.data("default")) {
            this._mandatory($msg);
            pass = false;
        }

        if (!pass)
            this.alert("", "<strong>Atenção!</strong> Há campos obrigatórios em branco.");

        return pass;
    },
    _mandatory: function ($el) {
        $el.unbind("change").change(function () {
            if ($(this).val() && $(this).val() != $(this).data("default"))
                $(this).unbind("change").parent().css("borderColor", "transparent");
        }).parent().css("borderColor", "red");
    },
    alert: function (type, message) {
        var alert_text = '<div class="alert {type}"><button type="button" class="close" data-dismiss="alert">&times;</button>{message}</div>',
            $alert = $(alert_text.replace("{type}", type).replace("{message}", message));

        $("form#message").before(
            $alert.hide()
        );
        $alert.slideDown(200);
        setTimeout(function () {
            $alert.slideUp(200, function () {
                $(this).remove();
            });
        }, 5000);
    },
    send: function (data) {
        var self = this;
        $.ajax({
            url: "/home/enviar",
            type: "POST",
            data: data,
            success: function (ret) {
                if (ret == "empty")
                    self.alert("", "<strong>Atenção!</strong> Há campos obrigatórios em branco.");
                else if (ret == "error")
                    self.alert("alert-error", "Houve um problema no envio, por favor tente novamente em instantes.");
                else {
                    self.alert("alert-success", "Mensagem enviada com sucesso!");
                    self.cleanUp();
                }
            },
            error: function () {
                self.alert("alert-error", "Houve um problema no envio, por favor tente novamente em instantes.");
            }
        });
    },
    cleanUp: function () {
        $("input:text,textarea").each(function(i, el) {
            $(el).val($(el).data("default"));
        });
    }
};
core.init();