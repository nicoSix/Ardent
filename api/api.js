const express = require('express');
const app = express();
const db = require('./db');
const bodyParser = require('body-parser');
const multer = require('multer');
const upload = multer({ dest: './uploads/' }).single("xlsArchitectures");
const xlsxj = require("xlsx-to-json");
const { v4: uuidv4 } = require('uuid');
const { storeArchitecture } = require('./db');
const basicAuth = require('express-basic-auth');
const { AUTH_USERS, USERNAMES } = require('./config');

const parseDBResults = res => {
    if(res["rows"]) {
        return {
            success: true,
            result: res["rows"]
        }
    }
    else {
        return {
            success: false,
            errorMsg: "Failed connexion to DB" + JSON.stringify(res)
        }
    }
}

const authorizedOnly = (req, res, next) => {
    if (USERNAMES.includes(req.auth.user)) {
        next();
    }
    else {
        res.status(401).send({
            success: false,
            errorMsg: "Unauthorized user."
        })
    }
}

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE, OPTIONS");
    res.header("Access-Control-Allow-Headers", "content-type, authorization");
    res.header("Access-Control-Allow-Credentials", true);

    if(req.method == "OPTIONS") {
        res.status(204).send()
    }
    else {
        next();
    }
});

app.use(basicAuth(AUTH_USERS));

app.get('/login', (req, res) => {
    switch(req.auth.user) {
        case 'six':
            res.status(200).send({ success: true, loggedUser: 'six' });
            break;

        case 'negri':
            res.status(200).send({ success: true, loggedUser: 'negri' });
            break;

        case 'herbaut':
            res.status(200).send({ success: true, loggedUser: 'herbaut' });
            break;

        default:
            res.status(401).send({
                success: false,
                errorMsg: "Authentication failed. Please provide a correct username or password."
            })
            break;
    }
});

app.get('/logout', (req, res) => {
    res.clearCookie('name').end();
});

app.get('/architectures', authorizedOnly, (req, res) => {
    db.getArchitectures().then((queryResult) => {
        const parsedResult = parseDBResults(queryResult);
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/papers', authorizedOnly, (req, res) => {
    db.getPapers().then(parsedResult => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.post('/architecture', authorizedOnly, (req, res) => {
    const newArchitecture = req.body;
    if(newArchitecture.name && newArchitecture.paper_id && newArchitecture.reader_description) {
        db.storeArchitecture(newArchitecture).then((parsedResult) => {
            if(parsedResult.success) res.status(200).send(parsedResult);
            else res.status(500).send(parsedResult);
        })
    }
    else {
        res.status(500).send({
            success: false,
            errorMsg: "Missing fields."
        })
    }
});

app.post('/paper', authorizedOnly, (req, res) => {
    const newPaper = req.body;
    if(newPaper.name && newPaper.authors && newPaper.added_by && newPaper.updated_by) {
        db.storePaper(newPaper).then((parsedResult) => {
            if(parsedResult.success) res.status(200).send(parsedResult);
            else res.status(500).send(parsedResult);
        })
    }
    else {
        res.status(500).send({
            success: false,
            errorMsg: "Missing fields."
        })
    }
});

app.post('/property', authorizedOnly, (req, res) => {
    db.storeProperty(req.body).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.post('/connection', authorizedOnly, (req, res) => {
    db.storeConnection(req.body).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.delete('/architecture/:id', authorizedOnly, (req, res) => {
    db.deleteArchitecture(req.params.id).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.delete('/property/:id', authorizedOnly, (req, res) => {
    db.deleteProperty(req.params.id).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.delete('/connection/:id', authorizedOnly, (req, res) => {
    db.deleteConnection(req.params.id).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.post('/component_instance', authorizedOnly, (req, res) => {
    db.storeComponentInstance(req.body).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.put('/component_instance/:id', authorizedOnly, (req, res) => {
    const newComponent = req.body;
    if(newComponent.name.length > 0 && newComponent.architectureId && newComponent.id) {
        db.modifyComponentInstance(newComponent).then((parsedResult) => {
            if(parsedResult.success) res.status(200).send(parsedResult);
            else res.status(500).send(parsedResult);
        })
    }
    else {
        res.status(500).send({
            success: false,
            errorMsg: "Missing fields."
        })
    }
});

app.put('/paper/:id', authorizedOnly, (req, res) => {
    const newPaper = req.body;
    if(newPaper.name && newPaper.name.length > 0 && newPaper.authors && newPaper.added_by && newPaper.updated_by) {
        db.modifyPaper(newPaper).then((parsedResult) => {
            if(parsedResult.success) res.status(200).send(parsedResult);
            else res.status(500).send(parsedResult);
        })
    }
    else {
        res.status(500).send({
            success: false,
            errorMsg: "Missing fields."
        })
    }
});


app.put('/architecture/:id', authorizedOnly, (req, res) => {
    const newArchitecture = req.body;
    if(newArchitecture.reader_description && newArchitecture.name && newArchitecture.id) {
        db.modifyArchitecture(newArchitecture).then((parsedResult) => {
            if(parsedResult.success) res.status(200).send(parsedResult);
            else res.status(500).send(parsedResult);
        })
    }
    else {
        res.status(500).send({
            success: false,
            errorMsg: "Missing fields."
        })
    }
});

app.post('/xls', authorizedOnly, async (req, res) => {
    await upload(req, res, async (err) => {
        try {
            await xlsxj({
                input: req.file.path, //the same path where we uploaded our file
                output: null, //we don't need output
            }, async (err, result) => {
                if(err) {
                    res.status(500).send({
                        success: false,
                        errorMsg: "Conversion failed: " + e
                    });
                }
                
                var storeSuccessCounter = 0;
                
                for(var i = 0; i < result.length; i++) {
                    if(result[i].title.length != 0 && result[i].abstract.length != 0) {
                        var storeResult = await storeArchitecture({
                            id: uuidv4(),
                            paper: result[i].title,
                            reader_description: result[i].abstract,
                            done_by: ""
                        })

                        if(storeResult["success"]) storeSuccessCounter++;
                    }
                }

                res.status(200).send({
                    success: true,
                    nbSuccessAdding: storeSuccessCounter,
                    nbFailedAdding: (result.length - storeSuccessCounter)
                });
            });
        } catch (e){
            res.status(500).send({
                success: false,
                errorMsg: "Conversion failed: " + e
            });
        }

        res.status(200)
    })
});

app.delete('/component_instance/:id', authorizedOnly, (req, res) => {
    db.deleteComponentInstance(req.params.id).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.delete('/paper/:id', authorizedOnly, (req, res) => {
    db.deletePaper(req.params.id).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/components_instances', authorizedOnly, (req, res) => {
    db.getComponentsInstances().then((queryResult) => {
        const parsedResult = parseDBResults(queryResult);
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/components_names', authorizedOnly, (req, res) => {
    db.getComponentsNames().then((queryResult) => {
        const parsedResult = parseDBResults(queryResult);
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/properties_names/:cname', authorizedOnly, (req, res) => {
    var cname = req.params.cname;
    db.getPropertiesNames(cname).then((queryResult) => {
        const parsedResult = parseDBResults(queryResult);
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/properties_names/', authorizedOnly, (req, res) => {
    db.getPropertiesNames().then((queryResult) => {
        const parsedResult = parseDBResults(queryResult);
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/properties_values/:pkey', authorizedOnly, (req, res) => {
    var pkey = req.params.pkey;
    db.getPropertyValues(pkey).then((queryResult) => {
        const parsedResult = parseDBResults(queryResult);
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/architecture/:id', authorizedOnly, (req, res) => {
    var id = req.params.id;
    db.getArchitecture(id).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.get('/component_instance/:id', authorizedOnly, (req, res) => {
    var id = req.params.id;
    db.getComponentInstance(id).then((parsedResult) => {
        if(parsedResult.success) res.status(200).send(parsedResult);
        else res.status(500).send(parsedResult);
    })
});

app.listen(8080, () => {
    console.log("Listening on port 8080.")
})