using from '../../srv/JobManager';
using from '../../db/schema';


annotate JobManager.JobPosting with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'JobManager.acceptJobPosting',
            Label : '{i18n>Accept}',
            Determining : true,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'JobManager.rejectJobPosting',
            Label : '{i18n>Reject}',
            Determining : true,
        },
    ]
);
annotate JobManager.JobPosting with @(
    UI.HeaderInfo : {
        TypeName : '{i18n>JobPosting}',
        TypeNamePlural : '',
    }
);
annotate JobManager.JobPosting with @(
    UI.SelectionFields : [
        status.name,]
);
annotate JobManager.JobPosting with {
    status @Common.Label : 'Status'
};

annotate JobManager.JobPosting with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : location,
            Label : '{i18n>Location}',
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : '{i18n>Description}',
            ![@UI.Hidden],
        },
        {
            $Type : 'UI.DataField',
            Value : requirements,
            Label : '{i18n>Requirements}',
        },
        {
            $Type : 'UI.DataField',
            Value : salary,
            Label : '{i18n>Salary}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : '{i18n>Status}',
        },
    ]
);
annotate JobManager.JobPosting with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>JobDetail}',
            ID : 'i18nJobDetail',
            Target : '@UI.FieldGroup#i18nJobDetail',
        },
    ],
    UI.FieldGroup #i18nJobDetail : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdAt,
                Label : '{i18n>CreatedAt}',
            },{
                $Type : 'UI.DataField',
                Value : location,
                Label : '{i18n>Location}',
            },
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : '{i18n>Title}',
            },
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : '{i18n>Description}',
            },{
                $Type : 'UI.DataField',
                Value : requirements,
                Label : '{i18n>Requirements}',
            },
            {
                $Type : 'UI.DataField',
                Value : salary,
                Label : '{i18n>Salary}',
            },],
    }
);
annotate JobManager.JobPosting with {
    requirements @UI.MultiLineText : true
};
annotate JobManager.JobPosting with {
    description @UI.MultiLineText : true
};

annotate JobManager.JobPosting {
} actions {
    rejectJobPosting @(
        Core.OperationAvailable: { $edmJson: { $Eq: [{ $Path: 'in/status_code' }, 'S'] } },
        Common: {
            SideEffects : {
                $Type : 'Common.SideEffectsType',
                TargetProperties : [
                    'in/status_code',
                ],
                TargetEntities : [
                    '/JobManager.EntityContainer/JobPosting'
                ],
            },  
        }
    );
    acceptJobPosting @(
        Core.OperationAvailable: { $edmJson: { $Eq: [{ $Path: 'in/status_code' }, 'S'] } },
        Common: {
            SideEffects : {
                $Type : 'Common.SideEffectsType',
                TargetProperties : [
                    'in/status_code',
                ],
                TargetEntities : [
                    '/JobManager.EntityContainer/JobPosting'
                ],
            },
        }
    );
} ;
annotate JobManager.Status with {
    name @Common.Label : '{i18n>Status}'
};

annotate JobManager.Status with {
    name @Common.Text : descr
};
annotate JobManager.JobPosting with @(
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
    UI.LineItem #tableView : [
        {
            $Type : 'UI.DataField',
            Value : jobId,
            Label : '{i18n>Jobid1}',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'description',
        },{
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Value : requirements,
            Label : '{i18n>Requirements}',
        },
        {
            $Type : 'UI.DataField',
            Value : salary,
            Label : '{i18n>Salary}',
        },
        {
            $Type : 'UI.DataField',
            Value : location,
            Label : '{i18n>Location}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
        },],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : '{i18n>JobPostings}',
    }
);
annotate JobManager.Status with {
    name @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'descr',
                },
            ],
            Label : 'Status',
        },
        Common.ValueListWithFixedValues : true
)};
annotate JobManager.Status with {
    descr @Common.Text : name
};
